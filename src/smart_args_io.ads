--------------------------------------------------------------
--
--                   Smart_Arguments
--
--                  Copyright (C) 2003 Jeffrey Creem
--
-- @filename smart_args_io.ads
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


with Ada.Strings.Unbounded;

package Smart_Args_IO is


  --
  -- When we are creating output help we force linewraps at
  -- Format_Output_Width. This may be set by users of the package
  -- via external calls.
  --
  Format_Output_Width   : Natural := 80;

  --
  -- Max_Deadspace_On_Line is the number of characters that we will allow to
  -- be "wasted" on an output line trying to wrap the lines at word breaks.
  --
  Max_Deadspace_On_Line : Natural;


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
  procedure Format(Item : in String; Indent : in Natural := 0);


  procedure Format(Item : in Ada.Strings.Unbounded.Unbounded_String;
      Indent : Natural := 0);

  --
  -- Procedure/Function: Format_Newline
  --
  -- Purpose : Writes a new line in a manner that is "Format" aware.
  --

  procedure Format_Newline;

 
  procedure Set_Col(Col : in Positive);

end Smart_Args_IO;
