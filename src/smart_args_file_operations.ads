--------------------------------------------------------------
--                                                                                                                         
--                   Smart_Arguments_File_Operations                                                                                                       
--                                                                          
--                  Copyright (C) 2004 Jeffrey Creem        
--
-- @filename smart_arguments.ads  
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
--  This package is intended for internal use of the Smart_Arguments
--  package. It encapsulates various filesystem operations.
--                                                                          

package Smart_Args_File_Operations is

  --
  -- Procedure/Function: File_Can_Be_Opened_Read_Only
  --
  -- Purpose: Returns true if it is possible to open the file specified by Name
  --          for read access.
  --

  function File_Can_Be_Opened_Read_Only(Name : in String) return Boolean;


  --
  -- Procedure/Function: Is_A_Directory
  --
  -- Purpose: Returns true if the given name specifies an existing directory
  --

  function Is_A_Directory (Name : in String) return Boolean;



  --
  -- Procedure/Function: Is_A_Writeable_Directory
  --
  -- Purpose: Returns true if the given name specifies an existing directory
  --          to which we have write access.
  --

  function Is_A_Writeable_Directory (Name : in String) return Boolean;
  
  
end Smart_Args_File_Operations;

