with Ada.Streams.Stream_IO;
with GNAT.OS_Lib;

package body Smart_Args_File_Operations is

  --
  -- Procedure/Function: File_Can_Be_Opened_Read_Only
  --
  -- Purpose: Returns true if it is possible to open the file specified by Name
  --          for read access.
  --

  function File_Can_Be_Opened_Read_Only(Name : in String) return Boolean is

    File : Ada.Streams.Stream_IO.File_Type;

  begin

    Ada.Streams.Stream_IO.Open(File => File, Mode => Ada.Streams.Stream_IO.In_File, Name => Name);
    Ada.Streams.Stream_IO.Close(File);
    return true;

  exception
    when others =>
      return false;

  end File_Can_Be_Opened_Read_Only;

  --
  -- Procedure/Function: Is_A_Directory
  --
  -- Purpose: Returns true if the given name specifies an existing directory
  --

  function Is_A_Directory (Name : in String) return Boolean is

  begin
    return GNAT.OS_Lib.Is_Directory(Name);
  end Is_A_Directory;



  --
  -- Procedure/Function: Is_A_Writeable_Directory
  --
  -- Purpose: Returns true if the given name specifies an existing directory
  --          to which we have write access.
  --

  function Is_A_Writeable_Directory (Name : in String) return Boolean is

  begin
    return GNAT.OS_Lib.Is_Writable_File(Name);
  end Is_A_Writeable_Directory;

end Smart_Args_File_Operations;

