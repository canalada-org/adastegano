--------------------------------------------------------------
--
--                   Smart_Arguments
--
--                  Copyright (C) 2003 Jeffrey Creem
--
-- @filename smart_args_io.adb
-- @author Jeffrey Creem
-- @date 18 June 2005
-- @brief Text output front end for the smart arguments library.
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
--
--


with Text_IO;
use Text_IO;

with Ada.Strings.Unbounded;
with Ada.Strings.Maps;
with Ada.Strings.Fixed;

package body Smart_Args_IO is



  --
  -- Procedure/Function: Format
  --
  -- Purpose : Writes the given Item to standard output such that
  --           if the addition of the current output and the item
  --           would extend past Format_Output_Width, we break
  --           the line and continue writing the rest of Item on
  --           subsequent lines. When we do the line breaks, we
  --           indent Indent spaces prior to starting output.
  --
  --           As input spills to new lines, Indent spaces will
  --           be displayed prior to restarting the output.
  --
  procedure Format(Item : in String; Indent : in Natural := 0) is

    Last        : Integer;
    Space_Map   : Ada.Strings.Maps.Character_Set := Ada.Strings.Maps.To_Set(' ');
    Blank_Index : Integer;

  begin

    --
    -- If the Item fits, write it. If not, write what fits on th line then
    -- recurse to finish the rest. This should be made smarter to break at words if
    -- possible.
    --
    if (Text_IO.Col + Item'length) <= Text_IO.Count(Format_Output_Width) then

      --
      -- If we are creating indented output, consume leading whitespace if present.
      --
      if Indent /= 0 then

        Text_IO.Put(Ada.Strings.Fixed.Trim(Item, Ada.Strings.Left));

      else

        Text_IO.Put(Item);

      end if;

    else
      --
      -- Figure out the portion of the Item that fits on the line, write it
      -- out and then recurse to print the rest of the line.
      --
      Last := Item'first + Integer(Text_IO.Count(Format_Output_Width) - Text_IO.Col);

      --
      -- If we appear to be breaking in the middle of a word, try not to.
      --
      if not (Item(Last) = ' ' or Item(Last) = '.' or Item(Last) = ',') then

        Blank_Index := Ada.Strings.Fixed.Index
          (Source => Item(Item'first .. Last),
          Set    => Space_Map,
          Going  => Ada.Strings.Backward);

        if Last - Blank_Index < Max_Deadspace_On_Line then

          Last := Blank_Index;

        end if;

      end if;

      --
      -- If we have been asked to indent the output, then make sure when we
      -- write this data we strip leading whitespace from the string before
      -- we write it.
      --
      if Indent /= 0 then

        Text_IO.Put_Line(Ada.Strings.Fixed.Trim
          (Item(Item'first .. Last), Ada.Strings.Left));

      else

        Text_IO.Put_Line(Item(Item'first .. Last));

      end if;


      --
      -- If we are are indenting, set the column to the desired indent point.
      --
      if Indent /= 0 then

        Text_IO.Set_Col(Text_IO.Count(Indent));

      end if;

      Format(Item => Item(Last + 1 .. Item'last), Indent => Indent);

    end if;

  end Format;


  procedure Format(Item : in Ada.Strings.Unbounded.Unbounded_String;
      Indent : Natural := 0) is

  use Ada.Strings.Unbounded;

  begin

    Format(Item => To_String(Item), Indent => Indent);

  end Format;



  --
  -- Procedure/Function: Format_Newline
  --
  -- Purpose : Writes a new line in a manner that is "Format" aware.
  --

  procedure Format_Newline is

  begin

    --
    -- For now this is pretty easy since we just use text_io for
    -- bookkeeping.
    --
    Text_IO.New_Line;

  end Format_Newline;


 
  procedure Set_Col(Col : in Positive) is

  begin
    Text_IO.Set_Col(Text_IO.Positive_Count(Col));
  end Set_Col;

end Smart_Args_IO;
