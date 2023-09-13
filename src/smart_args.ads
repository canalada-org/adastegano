--------------------------------------------------------------
--
--                   Smart_Arguments
--
--                  Copyright (C) 2003 Jeffrey Creem
--
-- @filename smart_args.ads
-- @author Jeffrey Creem
-- @date 15 November 2004
-- @brief Provide a structured interface to command line arguments
--
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
-- executable file  might be covered by the  GNU Public License.
--
-- Description
--  This package is designed to simplify the use of command
--  line arguments for controlling a program. The built in
--  Ada facilities for command line argument processing are
--  very basic. This package provide a higher level facility
--  for dealing with command lines. It is similar in purpose to GNU
--  getopts however it is used somewhat differently.
--
--  The concept that this package uses is that client programs
--  make a series of calls to "create" the arguments  that
--  the program can process (e.g. -f, --file, etc) . Once all of the
--  arguments are registered locally with this package then this package
--  can perform querys on the command line to determine what
--  argument prefix values are present and what (if any) subarguments
--  have been provided.
--
--  If the optional parameters to Create_Arguments are provided with
--  meaningul descriptions as to the parameters use then a fairly standard
--  help output can be displayed with a single call.
--
--

with Ada.Strings.Unbounded;

generic
   --
   -- In order to support simple unit testing, we make the
   -- elements of the Ada.Command_Line package generic parameters to
   -- this package. We can then perform a unit test without executing
   -- a series of command line arguments.
   --

   with function Argument_Count return Natural;
   with function Get_Argument(Index : in Positive) return String;
   with function Command_Name return String;

package Smart_Args is

  --
  -- Argument_Type holds the attributes about all defined command
  -- line arguments. Users of this package create an object of
  -- Argument_Type for each unique command line argument prefix.
  -- Users may then query this package to determine if the
  -- command line argument prefix (in either a short form such
  -- as -f or a long form such as -file) exists on the command line.
  --
  type Argument_Type is tagged private;

  --
  -- If the user of this package attempts to make a query about the
  -- specific attributes of an argument on the command line and the
  -- argument prefix is not present on the command line then a
  -- Argument_Not_Present_Error will be raised.
  --
  Argument_Not_Present_Error : exception;

  --
  -- If Create_Argument is called with command line argument prefixes that
  -- are not unique then a Duplicate_Argument_Error is raised.
  --
  Duplicate_Argument_Error   : exception;



  --
  -- Procedure/Function: Initialize
  --
  -- Purpose: Causes this package to forget any prior information from the
  --	      calls to the command line argument subprograms. 
  --
  

  --
  -- Procedure/Function: Create_Argument
  --
  -- Purpose: Creates/registers an argument that may be procecessed by
  --          this package.
  --
  --   Argument   : The returned object that can now be used to
  --                determine the status of arguments indicated by Short_Form
  --                or Long_Form on the command line.
  --
  --   Short_Form : Intended to be the typical single character (e.g. -f)
  --                style argument prefix format.
  --
  --   Long_Form  : Intended to be the more descriptive format for the argument
  --                prefix (e.g. --file). This packages does nothing to enforce
  --                that Long_Form is longer than Short_Form. One could
  --                simply view this as an alternate argument for Short_Form.
  --
  --   Required :   Indicates if the given command line argument is required
  --                in order for a particular command line to be considered
  --                valid.
  --
  --   Description : Used during the generation of the help output. It is
  --                 appended after displaying the arugment
  --                  (e.g.  -f/--file  - Specifies the filename to use.)
  --
  --   Number_Required_Subargs : Set non-zero if the argument (when present)
  --                 requires some specific number of sub-arguments.
  --
  --   Subarg_Description: Used in the short form help to describe
  --                       the nature of the sub-arguments.
  --
  --  Exceptions:
  --
  --          Duplicate_Argument_Error if the Long_Form or Short_Form non-null
  --          strings collide with a previous argument created via
  --          Create_Argument.
  --
  procedure Create_Argument (Argument : out Argument_Type;
    Short_Form              : in String;
    Long_Form               : in String  := "";
    Number_Required_Subargs : in Natural := 0;
    Required                : in Boolean := false;
    Description             : in String  := "";
    Subarg_Description      : in String  := "");



  --
  -- Procedure/Function: Create_Positional_Argument
  --
  -- Purpose: Creates/registers an argument that may be procecessed by
  --          this package. This procedure is used for arguments that are indicated
  --          by their position on the command line and which are not indicated
  --          by some argument prefix (e.g. Given a command line like:
  --            gcc hello.c -o hello.o
  --
  --          One would use the first form of Create_Argument to specify an argument
  --          returning information about hello.o and this form
  --          (Create_Positional_Argument) to specify and argument returning
  --          information about hello.c
  --
  --          One can create a pretty complicated command line using a
  --          combination of this form of Create in combination with the other
  --          form. This is not stated as a feature or as a bug but it is probably
  --          a warning. There is no need to ever use this form of the Create to
  --          create arguments but if one is trying to simulate the behaviour of
  --          some existing command line processor this should help.
  --
  --   Argument :   The returned object that can now be used to
  --                determine the status of arguments indicated by Short_Form
  --                or Long_Form on the command line.
  --
  --   Position:    Indicates the position on the command line where this
  --                argument lives. This is not an absolute position as is the
  --                case with Ada.Command_Line.Argument. The Index of these
  --                positional arguments is not disturbed by arguments created
  --                using the Create_Argument form. For example, given the
  --                command line :
  --                  do_something input.txt -f aux.txt -k -q -n 1.0 2.0 results.txt
  --                If one create an argument to handle -f with a single required
  --                argument and -n with 2 required arguments and -k and -q with
  --                0 required arguments then, the Index of input.txt will
  --                be 1 and the index of results.txt will be 2.
  --
  --   Required :   Indicates if the given command line argument is required
  --                in order for a particular command line to be considered
  --                valid. It is invalid to create a required positional argument
  --                at a position higher than a previously created non-required
  --                positional argument.
  --
  --   Short_Description : Used in the generation of help output when
  --                creating the short form help to represent the presence of
  --                this argument on the command line. Also used in the long
  --                form help prior to displaying the Description itself.
  --
  --   Description : Used during the generation of the help output. It is
  --                 appended after displaying the arugment
  --                  (e.g. {filename}  - The name of the file that is to be compiled.)
  --
  procedure Create_Positional_Argument
    (Argument         : out Argument_Type;
    Position          : in Positive;
    Required          : in Boolean := false;
    Short_Description : in String;
    Description       : in String := "");



  --
  -- Procedure/Function: Set_Argument_Validity
  --
  -- Purpose: This optional procedure may be called to indicate the data type and
  --          range of the subarguments of the given prefixed argument or of the
  --          specified positional argument.
  --          If this procedure is used, then calls to Arguments_Valid will take
  --          into account the type and range of data specified by the call to
  --          this procedure.
  --

  procedure Set_Argument_Validity
    (Argument : in Argument_Type;
    Min      : in Long_Float := Long_Float'first;
    Max      : in Long_Float := Long_Float'last);


  procedure Set_Argument_Validity
    (Argument : in Argument_Type;
    Min      : in Long_Integer;
    Max      : in Long_Integer);

  procedure Set_Argument_Validity_As_Input_Filename
    (Argument : in Argument_Type);



  --
  -- Procedure/Function: Argument_Present
  --
  -- Purpose: Returns true if there is an argument on the command
  --          line that is indicated by the given Argument.
  --
  --          One should not use this function until all Create argument
  --          calls have been completed.
  --

  function Argument_Present (
    Argument : in Argument_Type )
    return Boolean;


  --
  -- Procedure/Function: Argument_Image
  --
  -- Purpose: Returns the Short_Form or Long_Form string that was
  --          used to create the Argument or for positional
  --          arguments (which have no specific long/short string) returns
  --          a value like "1st", "2nd", 3rd", etc.
  --
  --          One should not use this function until all Create argument
  --          calls have been completed.
  --

  function Argument_Image
    (Argument  : in Argument_Type;
    Short_Form : in Boolean := true) return String;



  --
  -- Procedure/Function: Get_Subargument
  --
  -- Purpose: Returns the command line argument value that is offset
  --          from the given argument by Subargument_Index.
  --
  --          For example, if Argument were created with "-m" as the
  --          short form and the command line contained:
  --             -a -b -c 1.0 2.0 -m 10.0 12.0 dog -q
  --
  --          Then Get_Subargument would return 10.0 when subargument
  --          is 1, 12.0 when 2 and dog when 3. In addition, it would
  --          return -q if subargument_Index were 4 (i.e. there is no
  --          attempt made to validate that the subargument does not
  --          overlap another command line argument though programs
  --          should not be designed to make use of this fact).
  --
  --          Raises an Argument_Not_Present_Error if the given
  --          argument is not on the command line.
  --
  --
  --          One should not use this function until all Create argument
  --          calls have been completed.

  function Get_Subargument (
    Argument          : in Argument_Type;
    Subargument_Index : in     Positive )
    return String;


  --
  -- Procedure/Function: All_Required_Arguments_Present
  --
  -- Purpose: Returns true if all of the arguments that were created
  --          with Required set are present on the command line.
  --
  --          One should not use this function until all Create argument
  --          calls have been completed.

  function All_Required_Arguments_Present return Boolean;


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
    Error_On_Suspicious_Arguments : in Boolean := true) return Boolean;


  --
  -- Procedure/Function : Get_Command_Line_Error_Description
  --
  -- Purpose : If there is a problem with the command line then
  --           this function will return a string that describes the
  --           problem in a (somewhat) meaningful way.
  --
  --          One should not use this function until all Create argument
  --          calls have been completed.

  function Get_Command_Line_Error_Description return String;



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
    (Format_For_Output_Width      : in Positive := 79;
    Short_Form_Only              : in Boolean;
    Pre_Argument_Command_Summary : in String := "");



private

  --
  -- An Argument_List_Node_Type will hold all of the characteristics
  -- of the arguments that are created through the various Create
  -- procedures of this package.
  --
  type Argument_List_Node_Type;


  type Access_Argument_List_Node_Type is access Argument_List_Node_Type'class;

  --
  -- Argument_Type is the user visible version of the data associated
  -- with an argument.
  --
  type Argument_Type is tagged
     record
        Argument_Data : Access_Argument_List_Node_Type;
     end record;


  --
  -- Argument_Category_Type is used to keep track of which kind
  -- of argument has been created.
  type Argument_Category_Type is
        (-- Prefixed arguments are of the form Created by
         -- calls to Create_Argument (.e.g. -f filename.txt)
         Prefixed,
         -- Positional Arguments are of the form created by
         -- calls to Create_Positional_Argument. Arguments of
         -- this form are distinguishable on the command line only
         -- by their position.
         Positional);

  --
  -- We optionally allow the user to specify constraints as to which kinds of
  -- data are valid for a particular argument (either the argument itself in
  -- the case of positional arguments or the subarguments in the case of
  -- prefixed arguments).
  --
  type Argument_Data_Type is
        (Not_Specified,
         Floating_Type,
         Integer_Type,
         Input_File_Type,
         Output_File_Type,
         General_String);

  type Argument_Constraints_Type (Argument_Data_Is : Argument_Data_Type :=
    Not_Specified) is
  record
    case Argument_Data_Is is
      when Not_Specified | Input_File_Type | Output_File_Type |
          General_String =>
        null;
      when Floating_Type =>
        Min_Float : Long_Float;
        Max_Float : Long_Float;
      when Integer_Type =>
        Min_Int : Long_Integer;
        Max_Int : Long_Integer;
    end case;
  end record;


  type Argument_List_Node_Type (Argument_Is : Argument_Category_Type) is tagged
    record
    Description : Ada.Strings.Unbounded.Unbounded_String;

    --
    -- Properties determined by scanning the command line
    --
    Argument_Present : Boolean;
    --
    -- Index indicates location (once found) in Ada.Command_Line.Argument
    --
    Index            : Integer;

    --
    -- Indicates if this argument is required for the line to be considered
    -- valid.
    --
    Required         : Boolean;

    --
    -- Pointer to next element in the linked list of arguments
    --
    Next : Access_Argument_List_Node_Type;

    Argument_Constraints  : Argument_Constraints_Type;

    case Argument_Is is

      when Prefixed =>
        --
        -- Properties associated with users "Create" of the argument
        --
        Short_Form              : Ada.Strings.Unbounded.Unbounded_String;
        Long_Form               : Ada.Strings.Unbounded.Unbounded_String;
        Number_Required_Subargs : Natural;
        Subarg_Description      : Ada.Strings.Unbounded.Unbounded_String;

      when Positional =>

        Short_Description       : Ada.Strings.Unbounded.Unbounded_String;
        Positional_Index        : Integer;

    end case;

  end record;

  --
  -- Argument_List is a simple linked list that holds each of the Argument_Type's created
  -- as a result of the calls to Create_Argument.
  --
  Argument_List : Access_Argument_List_Node_Type;

end Smart_Args;
