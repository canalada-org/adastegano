--------------------------------------------------------------
--
--                       Smart_Arguments
--
--                  Copyright (C) 2003 Jeffrey Creem
--
-- This library is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public
-- License as published by the Free Software Foundation; either
-- version 2 of the License, or (at your option) any later version.
--
-- This library is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- General Public License for more details.
--
-- You should have received a copy of the GNU General Public
-- License along with this library; if not, write to the
-- Free Software Foundation, Inc., 59 Temple Place - Suite 330,
-- Boston, MA 02111-1307, USA.
--
-- As a special exception, if other files instantiate generics from
-- this unit, or you link this unit with other files to produce an
-- executable, this  unit  does not  by itself cause  the resulting
-- executable to be covered by the GNU General Public License. This
-- exception does not however invalidate any other reasons why the
-- executable file might be covered by the GNU Public License.
--


with Ada.Strings.Unbounded;
with Ada.Strings.Fixed;
with Ada.Strings.Maps;
with Ada.Exceptions;

with Smart_Args_File_Operations;
with Smart_Args_IO;
with Unchecked_Deallocation;

use Ada.Strings.Unbounded;

package body Smart_Args is

  --
  -- The manner that this package uses to store the data
  -- about the arguments has changed quite a bit from early versions.
  -- One remaining holdout from the old implementation is that we
  -- store quite a bit of data about the arguments in
  -- Ada.Strings.Unbounded.Unbounded_Strings. This made some sense
  -- in the old implementation but really buys us nothing in the
  -- current implemenation. Really no reason that all the strings
  -- could not just be simple access types on strings.
  --
  -- In either case, this package will give the appearance
  -- of a "leak" in since it never tries to free the memory
  -- it allocates (regardless of the string implementation). In
  -- the future it might be nice to add some sort of finalization
  -- to the package. It is not really that there is a leak per
  -- se (since we simply allocate during initialization a
  -- "fixed" ammount of storage which we never free) but if users
  -- were to use something like gnatmem to discover leaks in their
  -- own programs they would be distracted by the apparent leak
  -- in this package.



  --
  -- Command_Status stores a meaningful error string after we parse
  -- the command line if we find a problem with it.
  --
  Command_Status : Ada.Strings.Unbounded.Unbounded_String :=
    Ada.Strings.Unbounded.Null_Unbounded_String;


  type Boolean_Array_Type is array (Positive range <>) of Boolean;
  type Access_Boolean_Array_Type is access Boolean_Array_Type;


  procedure Free is new 
    Unchecked_Deallocation(Boolean_Array_Type, Access_Boolean_Array_type);

  Index_Contains_Valid_Argument : Access_Boolean_Array_Type := new 
    Boolean_Array_Type(1 .. Argument_Count);

  --
  -- We warn the user of the package about certain routines that should
  -- not be called before all create argument calls are completed. There are
  -- several reasons for this but one of the most important is tha
  -- can not determine positional arguments until we can account for all other
  -- parameter types. Each time a new parameter is created we reset
  -- Positional_Arguments_Identified to false. Each time a procedure is
  -- called that should not be called until all creates are complete we
  -- rebuild the positional arguments if Positional_Arguments_Identified is
  -- still false then reset Positional_Arguments_Identified to true.
  --
  Positional_Arguments_Identified : Boolean := false;



  --
  -- Procedure/Function: Initialize
  --
  -- Purpose: Causes this package to forget any prior information from the
  --	      calls to the command line argument subprograms. 
  --
  procedure Initialize is 
  begin

    Free(Index_Contains_Valid_Argument);
    Index_Contains_Valid_Argument := new 
      Boolean_Array_Type(1 .. Argument_Count);

    Positional_Arguments_Identified := false;

  end Initialize;


  --
  -- Returns the Index for Argument that contains the
  -- argument indicated by the parameter. Returns a negative value if
  -- the parameter is not found.
  --
  function Index_Of_Argument_Internal
      (Short_Form : in Ada.Strings.Unbounded.Unbounded_String;
      Long_Form   : in Ada.Strings.Unbounded.Unbounded_String) return Integer is

  begin

    --
    -- Each time through this loop we check the next element on the
    -- command line against the given argument and if it matches we
    -- return the index. If we exit the loop without finding a match
    -- return an invalid command line index.
    --
    for Current_Arg_Index in 1 .. Argument_Count loop

      declare

        Current_Arg : Ada.Strings.Unbounded.Unbounded_String :=
          Ada.Strings.Unbounded.To_Unbounded_String
            (Get_Argument(Current_Arg_Index));

      begin

        if (Current_Arg = Short_Form and
            Short_Form /= Ada.Strings.Unbounded.Null_Unbounded_String) or
            (Current_Arg = Long_Form and
            Long_Form /= Ada.Strings.Unbounded.Null_Unbounded_String) then

          return Current_Arg_Index;

        end if;

      end;

    end loop;

    return -1;

  end Index_Of_Argument_Internal;



  --
  -- Procedure/Function: Argument_Lookup
  --
  -- Purpose: Returns an access to the Argument_List_Node_Type that contains
  --          either the given Short_Form or Long_Form non-null argument.
  --          If none is found, returns null.
  --

  function Argument_Lookup
      (Short_Form : in Ada.Strings.Unbounded.Unbounded_String;
      Long_Form   : in Ada.Strings.Unbounded.Unbounded_String)
      return Access_Argument_List_Node_Type is

    Current_Argument  : Access_Argument_List_Node_Type := Argument_List;

  begin

    --
    -- Each time through this loop, we see if the current argument
    -- from the argument list is required and if it is, we check
    -- to see if it is on the command line. If not, we return false
    -- immediately. If we exit the loop, then all required arguments
    -- were found.
    --
    while Current_Argument /= null loop

      if Current_Argument.Argument_Is = Prefixed then

        if (Current_Argument.Long_Form = Long_Form and
            Long_Form /= Ada.Strings.Unbounded.Null_Unbounded_String) or
            (Current_Argument.Short_Form = Short_Form and
            Short_Form /= Ada.Strings.Unbounded.Null_Unbounded_String) then

          return Current_Argument;

        end if;
      end if;

      Current_Argument := Current_Argument.Next;

    end loop;

    return null;

  end Argument_Lookup;



  procedure Create_Argument (Argument : out Argument_Type;
      Short_Form              : in String;
      Long_Form               : in String := "";
      Number_Required_Subargs : in Natural := 0;
      Required                : in Boolean := false;
      Description             : in String := "";
      Subarg_Description      : in String := "") is

    New_Argument          : Access_Argument_List_Node_Type;
    Index_On_Command_Line : Integer;

    Short : Ada.Strings.Unbounded.Unbounded_String :=
      Ada.Strings.Unbounded.To_Unbounded_String(Short_Form);
    Long  : Ada.Strings.Unbounded.Unbounded_String :=
      Ada.Strings.Unbounded.To_Unbounded_String(Long_Form);

  begin
    --
    -- If we thought we had properly identified positional
    -- arguments, we are wrong since another create changes
    -- everything (potentially).
    --
    Positional_Arguments_Identified := false;

    if Argument_Lookup(Short_Form => Short, Long_Form => Long) /= null or
        Argument_Lookup(Short_Form => Long, Long_Form => Short) /= null then

      Ada.Exceptions.Raise_Exception
        (Duplicate_Argument_Error'identity, "Duplicate vesion of short or long form " &
        "of argument detected for :" & Short_Form & " or " &
        Long_Form);

    end if;

    Index_On_Command_Line := Index_Of_Argument_Internal
      (Short_Form => Short, Long_Form => Long);

    if Index_On_Command_Line > 0 then

      Index_Contains_Valid_Argument(Index_On_Command_Line) := true;

    end if;

    New_Argument := new Argument_List_Node_Type'
      (Argument_Is            => Prefixed,
      Short_Form              => Short,
      Long_Form               => Long,
      Required                => Required,
      Number_Required_Subargs => Number_Required_Subargs,
      Subarg_Description      => To_Unbounded_String(Subarg_Description),
      Description             => To_Unbounded_String(Description),
      Argument_Present        => Index_On_Command_Line > 0,
      Index                   => Index_On_Command_Line,
      Next                    => Argument_List,
      Argument_Constraints    => (Argument_Data_Is => Not_Specified));

    Argument_List := New_Argument;
    Argument      := (Argument_Data => New_Argument);

  end Create_Argument;




  procedure Create_Positional_Argument
      (Argument         : out Argument_Type;
      Position          : in Positive;
      Required          : in Boolean := false;
      Short_Description : in String;
      Description       : in String := "") is

    New_Argument          : Access_Argument_List_Node_Type;

  begin
    --
    -- If we thought we had properly identified positional
    -- arguments, we are wrong since another create changes
    -- everything (potentially).
    --
    Positional_Arguments_Identified := false;

    --
    -- For positional arguments we cannot be sure if they
    -- exist until the user has performed all of the create calls. So
    -- Create the argument in the linked list but don't determine yet if
    -- it is present.
    New_Argument := new Argument_List_Node_Type'
      (Argument_Is            => Positional,
      Required                => Required,
      Description             => To_Unbounded_String(Description),
      Argument_Present        => false,
      Index                   => 0,
      Short_Description       => To_Unbounded_String(Short_Description),
      Positional_Index        => Position,
      Next                    => Argument_List,
      Argument_Constraints    => (Argument_Data_Is => Not_Specified));

    Argument_List := New_Argument;
    Argument      := (Argument_Data => New_Argument);

  end Create_Positional_Argument;



  --
  -- Procedure/Function: Set_Argument_Validity
  --
  -- Purpose: This optional procedure may be called to indicate the data type and
  --          range of the subarguments of the given prefixed argument or of the
  --          specified positional argument.
  --          If this procedure is used, then calls to Arguments_Valid will take
  --          into account the type and range of data specified by the call to
  --           this procedure.
  --

  procedure Set_Argument_Validity
      (Argument : in Argument_Type;
      Min      : in Long_Float := Long_Float'first;
      Max      : in Long_Float := Long_Float'last) is

  begin

    Argument.Argument_Data.Argument_Constraints :=
      (Argument_Data_IS => Floating_Type, Min_Float => Min, Max_Float => Max);

  end Set_Argument_Validity;


  procedure Set_Argument_Validity
      (Argument : in Argument_Type;
      Min      : in Long_Integer;
      Max      : in Long_Integer) is

  begin

    Argument.Argument_Data.Argument_Constraints :=
      (Argument_Data_IS => Integer_Type, Min_Int => Min, Max_Int => Max);

  end Set_Argument_Validity;


  procedure Set_Argument_Validity_As_Input_Filename
      (Argument : in Argument_Type) is
  begin
    Argument.Argument_Data.Argument_Constraints :=
      (Argument_Data_IS => Input_File_Type);
  end Set_Argument_Validity_As_Input_Filename;



  --
  -- Procedure/Function: Find_Positional_Arguments
  --
  -- Purpose: Scans the command line looking for command line arguments
  --          that are associated with Arguments that were created as
  --          positional arguments. As it scans the command line it updates
  --          the fields of Argument_List to indicate where on the command
  --          line the positional arguments were found.
  --

  procedure Find_Positional_Arguments is

    --
    -- Each entry in Argument_Consumed will be marked as true once we determine
    -- that the Argument elemment associated with the position
    -- can be attributed to a prefixed argument or one of its subarguments.
    --
    Argument_Consumed : Boolean_Array_Type(1 .. Argument_Count) := 
      (others => false);

    --
    -- Current_Argument will be used to traverse Argument_List.
    --
    Current_Argument     : Access_Argument_List_Node_Type := Argument_List;

    First_Index_To_Check : Natural;

  begin

    --
    -- Scan list of potential arguments and for all non-positional
    -- arguments. Indicate in the Argument_Consumed status array if an actual
    -- argument has been used up in fufilling the constraints
    -- of the argument.
    --
    while Current_Argument /= null loop

      if Current_Argument.Argument_Is /= Positional and 
         Current_Argument.Argument_Present then
        --
        -- We know that at least one position has been consumed by this
        -- presence of this argument. Indicate it.
        --
        Argument_Consumed(Current_Argument.Index) := true;
        --
        -- Now for each required subargument index, mark the command
        -- line argument associated with it as consumed.
        --
        for Subarg_Index in Current_Argument.Index + 1 ..
            Current_Argument.Index + Current_Argument.Number_Required_Subargs loop
          --
          -- On a malformed command line, we could run out of actual arguments
          -- while trying to mark all of the subarguments.
          --
          exit when Subarg_Index > Argument_Count;
          Argument_Consumed(Subarg_Index) := true;

        end loop;

      elsif Current_Argument.Argument_Is = Positional then
        --
        -- Resetting present to false is especially important in the odd
        -- case where the user calls a routine "early" and we establish
        -- positional parameters too early.
        --
        Current_Argument.Argument_Present := false;

      end if;

      Current_Argument := Current_Argument.Next;

    end loop;


    --
    -- Now that we have a table that indicates which actual
    -- argument values are spoken for we can go
    -- and allocate any remaining ones to positional arguments.
    --
    First_Index_To_Check := Argument_Consumed'first;
    Current_Argument := Argument_List;

    while Current_Argument /= null loop

      if Current_Argument.Argument_Is = Positional then

        --
        -- Scan the list array that indicates if arguments have
        -- been consumed and if not, then this positional argument
        -- is associated with the Argument at the
        -- index and the argument is marked as consumed.
        --
        for Index in First_Index_To_Check .. Argument_Consumed'last loop

          if not Argument_Consumed(Index) then
            --
            -- This element was not consumed by a prefixed argument
            -- or its subarguments. It is now consumed by a positional
            -- argument.
            --
            Argument_Consumed(Index) := true;

            --
            -- Indicate in the node pointed to by Current_Argument that
            -- this positional argument is indeed present and mark the index
            -- at which it was found.
            --
            Current_Argument.Argument_Present := true;
            Current_Argument.Index := Index;

            First_Index_To_Check := Index + 1;
            exit;

          end if;

        end loop;

      end if;

      Current_Argument := Current_Argument.Next;

    end loop;

  end Find_Positional_Arguments;


  function Argument_Present (
      Argument : in Argument_Type )
      return Boolean is

  begin

    if not Positional_Arguments_Identified then
      Find_Positional_Arguments;
    end if;


    if Argument.Argument_Data /= null then

      return Argument.Argument_Data.Argument_Present;

    else

      return false;

    end if;

  end Argument_Present;



  function Get_Subargument (      Argument          : in Argument_Type;
      Subargument_Index : in     Positive )
      return String is

  begin

    if Argument.Argument_Data = null then

      Ada.Exceptions.Raise_Exception
        (Argument_Not_Present_Error'identity, "Could not find subargument " &
        "argument does not appear to have been created.");

    elsif Argument.Argument_Data.Index + Subargument_Index > Argument_Count then

      Ada.Exceptions.Raise_Exception
        (Argument_Not_Present_Error'identity, "Could not find subargument" &
        Positive'image(Subargument_Index) & "for argument " & 
        To_String(Argument.Argument_Data.Short_Form) &
        " ran out of arguments on command line.");

    elsif not Argument.Argument_Data.Argument_Present then

      Ada.Exceptions.Raise_Exception
        (Argument_Not_Present_Error'identity, "Could not find subargument" &
        Positive'image(Subargument_Index) & "for argument " & 
        To_String(Argument.Argument_Data.Short_Form));

    else

      return Get_Argument(Argument.Argument_Data.Index + Subargument_Index);

    end if;

  end Get_Subargument;



  --
  -- Procedure/Function: Get_Ordinal_Suffix
  --
  -- Purpose: Returns a string such as 'th' or 'st' based on the
  --          numeric character provided in Num.
  --

  function Get_Ordinal_Suffix(Num : in Character) return String is

  begin

    case Num is

      when '0' | '4' | '5' | '6' |'7'|'8'|'9' =>

        return "th";

      when '1' =>

        return "st";

      when '2' =>

        return "nd";

      when '3' =>

        return "rd";

      when others =>

        raise Constraint_Error;

    end case;

  end Get_Ordinal_Suffix;


  function Argument_Image
      (Argument   : in Argument_Type;
      Short_Form : in Boolean := true) return String is

  begin

    if Argument.Argument_Data /= null then

      case Argument.Argument_Data.Argument_Is is

        when Prefixed =>

          if Short_Form then

            return To_String(Argument.Argument_Data.Short_Form);

          else

            return To_String(Argument.Argument_Data.Long_Form);

          end if;

        when Positional =>

          declare
            The_Image : constant String := Integer'image
              (Argument.Argument_Data.Positional_Index);
          begin
            return The_Image(The_Image'first + 1 .. The_Image'last) &
                     Get_Ordinal_Suffix(The_Image(The_Image'last));
          end;

      end case;

    else

      Ada.Exceptions.Raise_Exception
        (Argument_Not_Present_Error'identity, "Argument not created");

    end if;

  end Argument_Image;



  --
  -- Procedure/Function: All_Required_Arguments_Present
  --
  -- Purpose: Returns true if all of the arguments that were created
  --          with Required set are present on the command line.
  --

  function All_Required_Arguments_Present return Boolean is

    Current_Argument : Access_Argument_List_Node_Type := Argument_List;

  begin

    if not Positional_Arguments_Identified then

      Find_Positional_Arguments;

    end if;


    --
    -- Each time through this loop, we see if the current argument
    -- from the argument list is required and if it is, we check
    -- to see if it is on the command line. If not, we return false
    -- immediately. If we exit the loop, then all required arguments
    -- were found.
    --
    while Current_Argument /= null loop

      if Current_Argument.Required and then not

          Current_Argument.Argument_Present then

        return false;

      end if;

      Current_Argument := Current_Argument.Next;

    end loop;

    return true;

  end All_Required_Arguments_Present;


  --
  -- Procedure/Function: All_Required_Subargs_Present
  --
  -- Purpose: Checks the command line and for all arguments
  --          that have REQUIRED subargument(s), verify that there
  --          are subargument(s) present and that they do not
  --          collide with predefined arguments (indicating
  --          that there really are missing subarguments). For
  --          example assume we define -f as requiring one argument
  --          and we define -v as a valid argument.
  --          Given the command line -f -v we would return false
  --          since while something follows the -f, it is a predefined
  --          argument and therefore we can not tell the difference between
  --          the subargument and the actual argument -v.
  --
  --          Sets the package level "Command_Status" with a text
  --          description of the problem with the line.
  --
  function All_Required_Subargs_Present return Boolean is

    Current_Argument : Access_Argument_List_Node_Type := Argument_List;

    use Ada.Strings.Unbounded;

  begin

    --
    -- Loop throufh all the arguments in the Argument_List and for those
    -- that are present, verify that any required subargs do not
    -- "collide" with defined arguments.
    --
    Check_All_Arguments :
      while Current_Argument /= null loop
      --
      -- Check to see if this argument appeared on the command line and if
      -- it even requires subarguments.
      --
      if Current_Argument.Argument_Is = Prefixed and then 
         (Current_Argument.Argument_Present and
          Current_Argument.Number_Required_Subargs > 0) then

        --
        -- Check to see if the highest required subargument for this argument
        -- would extend past the end of the Argument_Count.
        --
        if Current_Argument.Index + Current_Argument.Number_Required_Subargs 
           > Argument_Count then

          Command_Status := To_Unbounded_String
            ("Insufficient arguments on command line for ") &
            Current_Argument.Short_Form & '/' & Current_Argument.Long_Form;

          return false;

        end if;

        --
        -- Each time through this loop, we check if the command line
        -- argument located at the location of the current subargument collides
        -- with one of the predefined command line arguments.
        --
        for Subarg_Index in 1 .. Current_Argument.Number_Required_Subargs loop

          declare

            Current_Command_Line_Argument : Ada.Strings.Unbounded.Unbounded_String :=
              To_Unbounded_String
                (Get_Argument(Current_Argument.Index + Subarg_Index));

          begin

            if Argument_Lookup(Short_Form => Current_Command_Line_Argument,
                Long_Form => Current_Command_Line_Argument) /= null
                then

              Command_Status := To_Unbounded_String
                ("Missing #" & Integer'image(Subarg_Index) &
                 " subargument on command line argument :" &
                 Get_Argument(Current_Argument.Index));

              return false;

            end if;

          end;

        end loop;

      end if;

      Current_Argument := Current_Argument.Next;

    end loop Check_All_Arguments;

    return true;

  end All_Required_Subargs_Present;



  --
  -- Procedure/Function: Suspicious_Arguments_Present
  --
  -- Purpose: Returns true if there is a argument on the command line
  --          that appears to be a command line argument but which is not a valid
  --          user specified command line argument.
  --

  function Suspicious_Arguments_Present
      (Short_Qualifier : in String;
      Long_Qualifier  : in String) return Boolean is

    use Ada.Strings.Unbounded;

  begin

    --
    -- Each time through this loop, we check an element on the Ada.Command_Line
    -- to see if we can attribute it to one of the Arguments that were created through
    -- the various create calls. As soon as we find one that we can not attribute
    -- to a created argument, create an error message and exit.
    --
    for Arg_Index in 1 .. Argument_Count loop

      --
      -- Check to see if this particular command line index is directly
      -- associated with a command line argument specifier.
      --
      if not Index_Contains_Valid_Argument(Arg_Index) then

        --
        -- It is not, but this could still just be a valid subargument. So do
        -- some sanity checking on the actual text of the argument and see
        -- if it looks suspicious.
        --
        declare

          Current_Arg : constant String := Get_Argument(Arg_Index);

        begin

          --
          -- If the command line argument at the current index is long enough to at least
          -- contain a short argument qualifier (e.g. a '-') then check to see if it starts
          -- with a short argument qualifier. If it does, and if the rest of the 
          -- argument is not numeric then we have something suspicious. 
          -- Note we look for the numeric values first
          -- since something like -1.0 is a reasonable subargument.
          --
          if (Current_Arg'length > Short_Qualifier'length and
              Short_Qualifier'length > 0) and then
              (Current_Arg(Current_Arg'first .. Current_Arg'first + 
                Short_Qualifier'length - 1) = Short_Qualifier and
              Current_Arg(Current_Arg'first + Short_Qualifier'length) not in '0' .. '9')
          then

            Command_Status := To_Unbounded_String("Found unknown argument :" &
                                                  Current_Arg);
            return true;

          end if;

          --
          -- Now, do a similar check looking to see if the text of this argument appears to
          -- start with a Long_Argument qualifier.
          --
          if (Current_Arg'length > Long_Qualifier'length and
              Long_Qualifier'length > 0) and then
              (Current_Arg(Current_Arg'first .. Current_Arg'first +
                Long_Qualifier'length - 1) = Long_Qualifier) then

            Command_Status := To_Unbounded_String("Found unknown argument :" &
                                                    Current_Arg);
            return true;

          end if;

        end;

      end if;

    end loop;

    return false;

  end Suspicious_Arguments_Present;





  --
  -- Procedure/Function : Argument_Data_At_Index_Satisfies_Constraints
  --
  -- Purpose : Checks the data at on the command line at the given index
  --           to see if it satisfies the given constraint. Returns true
  --           if it does and false otherwise.
  --

  function Argument_Data_At_Index_Satisfies_Constraints(Index : in Natural;
      Constraint : in Argument_Constraints_Type) return Boolean is

    Argument_Text : constant String := Get_Argument(Index);

  begin

    case Constraint.Argument_Data_Is is

      when Not_Specified | General_String =>

        return true;

      when Floating_Type =>

        declare
          Temp : Long_Float;
        begin
          Temp := Long_Float'value(Argument_Text);
          return Temp >= Constraint.Min_Float and Temp <= Constraint.Max_Float;
        exception
          when others =>
            return false;
        end;

      when Integer_Type =>

        declare
          Temp : Long_Integer;
        begin

          Temp := Long_Integer'value(Argument_Text);

          return Temp >= Constraint.Min_Int and Temp <= Constraint.Max_Int;

        exception
          when others =>
            return false;
        end;

      when Input_File_Type =>

        return Smart_Args_File_Operations.File_Can_Be_Opened_Read_Only
          (Get_Argument(Index));

      when Output_File_Type =>

        return true;

    end case;

  end Argument_Data_At_Index_Satisfies_Constraints;



  --
  -- Procedure/Function : To_String
  --
  -- Purpose : Converts the given constraints to a human readable string that
  --           describes the limitations of the constraint
  --

  function To_String(Constraint : in Argument_Constraints_Type) return String is

  begin

    case Constraint.Argument_Data_Is is

      when Not_Specified | General_String =>
        return  "Just about anything";

      when Input_File_Type =>
        return "Valid input filename";

      when Output_File_Type =>
        return "Valid output filename";

      when Floating_Type =>
        return "Floating value between " & Long_Float'image(Constraint.Min_Float) &
          " and " & Long_Float'image(Constraint.Max_Float);

      when Integer_Type =>
        return "Integer value between " & Long_Integer'image(Constraint.Min_Int) &
          " and " & Long_Integer'image(Constraint.Max_Int);

    end case;

  end To_String;


  --
  -- Procedure/Function : Argument_Data_Satisfies_User_Specified_Constraints
  --
  -- Purpose : Returns true if all arguments (and subarguments) satisfy any
  --           user specified constraints and false otherwise.
  --

  function Argument_Data_Satisfies_User_Specified_Constraints return Boolean is

    Current_Argument : Access_Argument_List_Node_Type := Argument_List;

  begin
    --
    -- Each time through this loop we check to see if an argument specifier
    -- that has constraints on what data it may contain meets the data validity
    -- requirements.
    --
    while Current_Argument /= null loop

      if Current_Argument.Argument_Present then

        case Current_Argument.Argument_Is is

          when Prefixed =>

            for Subarg_Offset in 1 .. Current_Argument.Number_Required_Subargs loop
              if not Argument_Data_At_Index_Satisfies_Constraints
                  (Index => Current_Argument.Index + Subarg_Offset,
                  Constraint => Current_Argument.Argument_Constraints)
                  then

                Command_Status := To_Unbounded_String("Subargument invalid. Expected " &
                  To_String(Current_Argument.Argument_Constraints) & ". Found " &
                  Get_Argument(Current_Argument.Index + Subarg_Offset) &
                  " after " & Get_Argument(Current_Argument.Index));

                return False;

              end if;

            end loop;

          when Positional =>

            if not Argument_Data_At_Index_Satisfies_Constraints
                (Index => Current_Argument.Index,
                Constraint => Current_Argument.Argument_Constraints)
                then

              Command_Status := To_Unbounded_String
               ("Positional argument invalid. Expected " &
                To_String(Current_Argument.Argument_Constraints) & ". Found " &
                Get_Argument(Current_Argument.Index) &
                " at " & Integer'image(Current_Argument.Index) & " argument");

              return False;

            end if;

        end case;

      end if;

      Current_Argument := Current_Argument.Next;

    end loop;

    return True;

  end Argument_Data_Satisfies_User_Specified_Constraints;


  --
  -- Procedure/Function : Arguments_Valid
  --
  -- Purpose : Performs a fairly complete check on the command line to
  --           validate the arguments.
  --
  --           Checks include:
  --            * All arguments marked as required are present
  --            * All arguments with required subarguments have subargument
  --              present on the line and non of these subarguments 'collide' with
  --              an argument that has been created via Create_Argument.
  --            If Error_On_Suspicious_Arguments is enabled true then we also
  --            will generate errors for:
  --            * Unrecognized arguments (i.e. arguments that are preceeded by
  --              a Short_Qualifier or Long_Qualifier but which were not indicated
  --              by any call to Create_Argument)
  --
  --
  --          One should not use this function until all Create argument
  --          calls have been completed.

  function Arguments_Valid
      (Short_Qualifier              : in String := "-";
      Long_Qualifier                : in String := "--";
      Error_On_Suspicious_Arguments : in Boolean := true) return Boolean is

  begin

    Command_Status := Ada.Strings.Unbounded.Null_Unbounded_String;

    if not All_Required_Arguments_Present then

      Command_Status := To_Unbounded_String("Missing required arguments");
      return false;

    elsif not All_Required_Subargs_Present then

      return false;

    elsif Error_On_Suspicious_Arguments and
        Suspicious_Arguments_Present
        (Short_Qualifier => Short_Qualifier, Long_Qualifier => Long_Qualifier)  then

      return false;

    else

      return Argument_Data_Satisfies_User_Specified_Constraints;

    end if;

  end Arguments_Valid;


  --
  -- Procedure/Function : Get_Command_Line_Error_Description
  --
  -- Purpose : If there is a problem with the command line then
  --           this function will return a string that describes the
  --           problem in a (somewhat) meaningful way.
  --

  function Get_Command_Line_Error_Description return String is

    Dummy_Status : Boolean;

  begin

    if Command_Status = Null_Unbounded_String then

      Dummy_Status := Arguments_Valid;

    end if;

    return To_String(Command_Status);

  end Get_Command_Line_Error_Description;


  --
  -- Procedure/Function : Longest_Argument_Pair
  --
  -- Purpose : Traverses the elements of the Argument_List and returns the length of
  --           the longest pair of arguments (Long and short form combined)
  --

  function Longest_Argument_Pair return Natural is

    Longest_Pair     : Natural := 0;
    Current_Argument : Access_Argument_List_Node_Type := Argument_List;
    Current_Length   : Natural;

  begin
    --
    -- Each time through this loop, we create write an argument description
    -- for the an argument and then move on to the next argument until none
    -- are left.
    --
    while Current_Argument /= null loop

      case Current_Argument.Argument_Is is

        when Prefixed =>

          Current_Length := Length(Current_Argument.Short_Form) +
                            Length(Current_Argument.Long_Form);

          if Current_Length > Longest_Pair then

            Longest_Pair := Current_Length;

          end if;

        when Positional =>
          null;
      end case;

      Current_Argument := Current_Argument.Next;

    end loop;

    return Longest_Pair;

  end Longest_Argument_Pair;



  --
  -- Procedure/Function : Display_Positional_Argument_Help
  --
  -- Purpose : Displays help for Argument. It is assumed to be a positional
  --           argument. Text for the help is indented as specified in Indent.
  --

  procedure Display_Positional_Argument_Help
      (Argument : in Argument_List_Node_Type'class;
      Indent   : in Positive) is

  begin

    Smart_Args_IO.Format(Item => "  " & Argument.Short_Description);

    Smart_Args_IO.Set_Col(Indent);

    Smart_Args_IO.Format
      (Item   => Argument.Description,
       Indent => Indent);

    Smart_Args_IO.Format_Newline;
    Smart_Args_IO.Format_Newline;

  end Display_Positional_Argument_Help;


  --
  -- Procedure/Function : Display_Positional_Argument_Short_Help
  --
  -- Purpose : Displays short help for Argument. It is assumed to be a positional
  --           argument.
  --

  procedure Display_Positional_Argument_Short_Help
             (Argument : in Argument_List_Node_Type'class) is

  begin

    if Argument.Required then

      Smart_Args_IO.Format(To_String(Argument.Short_Description));

    else

      Smart_Args_IO.Format("[" & To_String(Argument.Short_Description) & "] ");

    end if;

  end Display_Positional_Argument_Short_Help;


  --
  -- Procedure/Function : Display_Prefixed_Argument_Short_Help
  --
  -- Purpose : Displays short help for Argument. It is assumed to be a prefixed
  --           argument.
  --

  procedure Display_Prefixed_Argument_Short_Help
      (Argument : in Argument_List_Node_Type'class) is

  begin

    if Argument.Required then

      Smart_Args_IO.Format(Item => Argument.Short_Form);

    else

      Smart_Args_IO.Format(Item => "[" & Argument.Short_Form);

    end if;

    if Argument.Number_Required_Subargs > 0 then

      Smart_Args_IO.Format(Item => " " & Argument.Subarg_Description);

    elsif Length(Argument.Subarg_Description) > 0 then

      Smart_Args_IO.Format(Item => " [" & Argument.Subarg_Description & "]");

    end if;


    if not Argument.Required then

      Smart_Args_IO.Format(Item => "] ");

    else

      Smart_Args_IO.Format(Item => " ");

    end if;

  end Display_Prefixed_Argument_Short_Help;


  --
  -- Procedure/Function: Sort_Argument_Templates
  --
  -- Purpose: Sorts the linked list of argument templates alphabetically
  --          based on the short form of the argument for Prefixed arguments
  --          and based on the position for positional arguments.
  --

  procedure Sort_Argument_Templates is

    function Less_Than(L, R : in Access_Argument_List_Node_Type) return Boolean is

    begin
      if L.Argument_Is = R.Argument_Is then
        case L.Argument_Is is
          when Prefixed  =>
            return L.Short_Form < R.Short_Form;
          when Positional =>
            return L.Positional_Index < R.Positional_Index;
        end case;
      else
        return L.Argument_Is = Prefixed;
      end if;
    end Less_Than;

    Argument_Count : Integer := 0;
    Current_Argument : Access_Argument_List_Node_Type := Argument_List;

  begin

    --
    -- Count the number of arguments in the Argument_List
    --
    while Current_Argument /= null loop
      Current_Argument := Current_Argument.Next;
      Argument_Count := Argument_Count + 1;
    end loop;

    declare

      type Argument_List_Array_Type is array (1 .. Argument_Count) of
           Access_Argument_List_Node_Type;
      Argument_List_Array : Argument_List_Array_Type;
      Temp                : Access_Argument_List_Node_Type;

    begin
      Argument_Count := 1;
      Current_Argument := Argument_List;
      --
      -- Copy the elements of the argument list into an array
      --
      while Current_Argument /= null loop
        Argument_List_Array(Argument_Count) := Current_Argument;
        Current_Argument := Current_Argument.Next;
        Argument_Count := Argument_Count + 1;
      end loop;

      --
      -- Sort the list in the array.
      --
      for Current_Fill_Index in Argument_List_Array'range loop
        for Current_Check_Index in Current_Fill_Index + 1 .. Argument_List_Array'last loop

          if Less_Than(Argument_List_Array(Current_Check_Index),
                       Argument_List_Array(Current_Fill_Index))
          then
            Temp := Argument_List_Array(Current_Check_Index);
            Argument_List_Array(Current_Check_Index) := 
              Argument_List_Array(Current_Fill_Index);
            Argument_List_Array(Current_Fill_Index) := Temp;
          end if;

        end loop;
      end loop;

      --
      -- Now fix the "next" field to rebuild the linked list.
      --
      for Index in Argument_List_Array'first .. Argument_List_Array'last - 1 loop
        Argument_List_Array(Index).Next := Argument_List_Array(Index+1);
      end loop;

      --
      -- Reset the head and tail of the list
      --
      Argument_List_Array(Argument_List_Array'last).Next := null;
      Argument_List := Argument_List_Array(Argument_List_Array'first);

    end;

  end Sort_Argument_Templates;


  --
  -- Procedure/Function: Display_Help
  --
  -- Purpose: Writes help output to standard output based on the
  --          arguments that have been created. If Short_Form_Only
  --          is indicated then only a brief synopsis of the legal
  --          arguments is displayed.
  --
  --          If Short_Form_Only is not specified, then the
  --          short form help will be displayed, followed by the
  --          Pre_Argument_Command_Summary followed by the
  --          line -by- line list of arguments and their descriptions.
  --
  --          One should not use this function until all Create argument
  --          calls have been completed.

  procedure Display_Help
      (Format_For_Output_Width     : in Positive := 79;
      Short_Form_Only              : in Boolean;
      Pre_Argument_Command_Summary : in String := "") is

    Current_Argument : Access_Argument_List_Node_Type := Argument_List;
    Arg_Indent       : Natural := Longest_Argument_Pair + 3;
    Max_Indent       : Natural := Format_For_Output_Width - 
                                    (Format_For_Output_Width * 2) / 3;

    Actual_Indent    : Natural := Arg_Indent;

  begin

    Sort_Argument_Templates;

    if Actual_Indent > Max_Indent then

      Actual_Indent := Max_Indent;

    end if;

    Smart_Args_IO.Format_Output_Width   := Format_For_Output_Width;
    Smart_Args_IO.Max_Deadspace_On_Line := Integer(Smart_Args_IO.Format_Output_Width) / 8;

    Smart_Args_IO.Format(Item => "Usage: ");

    Smart_Args_IO.Format(Item => Command_Name & ' ');

    --
    -- Each time through this loop, we create write an argument description
    -- for the an argument and then move on to the next argument until none
    -- are left.
    --
    while Current_Argument /= null loop

      case Current_Argument.Argument_Is is

        when Prefixed =>

          Display_Prefixed_Argument_Short_Help(Current_Argument.all);

        when Positional =>

          Display_Positional_Argument_Short_Help(Current_Argument.all);

      end case;

      Current_Argument := Current_Argument.Next;

    end loop;


    if not Short_Form_Only then

      Smart_Args_IO.Format_Newline;
      Smart_Args_IO.Format_Newline;

      if Pre_Argument_Command_Summary'length > 0 then

        Smart_Args_IO.Format(Pre_Argument_Command_Summary);
        Smart_Args_IO.Format_Newline;
        Smart_Args_IO.Format_Newline;

      end if;

      Current_Argument := Argument_List;

      --
      -- Each time through this loop, we write out the short and long form for an
      -- argument followed by the arguments description.
      --
      while Current_Argument /= null loop

        case Current_Argument.Argument_Is is
          when Prefixed =>

            if Current_Argument.Short_Form /= Null_Unbounded_String and
                Current_Argument.Long_Form /= Null_Unbounded_String then

              Smart_Args_IO.Format(Item => "  " & Current_Argument.Short_Form & '/' &
                     Current_Argument.Long_Form & ' ');

            elsif Current_Argument.Short_Form /= Null_Unbounded_String then

              Smart_Args_IO.Format(Item => "  " & Current_Argument.Short_Form & ' ');

            elsif Current_Argument.Long_Form /= Null_Unbounded_String then

              Smart_Args_IO.Format(Item => "  " & Current_Argument.Long_Form & ' ');

            end if;

            Smart_Args_IO.Set_Col(Actual_Indent);

            Smart_Args_IO.Format
              (Item   => Current_Argument.Description,
               Indent => Actual_Indent);

            Smart_Args_IO.Format_Newline;
            Smart_Args_IO.Format_Newline;

          when Positional =>

            Display_Positional_Argument_Help(Current_Argument.all, Actual_Indent);

        end case;

        Current_Argument := Current_Argument.Next;

      end loop;

    end if;

    Smart_Args_IO.Format_Newline;

  end Display_Help;


end Smart_Args;
