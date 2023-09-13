--------------------------------------------------------------
--
--                   Smart_Arguments
--
--                  Copyright (C) 2005 Jeffrey Creem
--
-- @filename smart_args.ads
-- @author Jeffrey Creem
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
--   This package instantiates the generic Smart_Args such that
--   it makes use of the normal Ada.Command_Line facilities to
--   get access to the command line arguments.
--

with Ada.Command_Line;
with Smart_Args;
package Smart_Arguments is new Smart_Args
  (Argument_Count => Ada.Command_Line.Argument_Count,
   Get_Argument   => Ada.Command_Line.Argument,
   Command_Name   => Ada.Command_Line.Command_Name);

