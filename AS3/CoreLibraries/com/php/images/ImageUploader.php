<?php

	$MAXIMUM_FILESIZE = 1024 * 300; // 300KB
	$MAXIMUM_FILE_COUNT = 10; // keep maximum 10 files on server
	echo exif_imagetype($_FILES['Filedata']);
	
	if ($_FILES['Filedata']['size'] <= $MAXIMUM_FILESIZE)
	{
		move_uploaded_file($_FILES['Filedata']['tmp_name'], "./temporary/".$_FILES['Filedata']['name']);
		$type = exif_imagetype("./temporary/".$_FILES['Filedata']['name']);
		
		if ($type == 1 || $type == 2 || $type == 3)
		{
			rename("./temporary/".$_FILES['Filedata']['name'], "./uimages/".$_FILES['Filedata']['name']);
		}
		else
		{
			unlink("./temporary/".$_FILES['Filedata']['name']);
		}
	}
	
	$directory = opendir('./uimages/');
	$files = array();
	
	while ($file = readdir($directory))
	{
		array_push($files, array('./uimages/'.$file, filectime('./uimages/'.$file)));
	}
	usort($files, sorter);
	if (count($files) > $MAXIMUM_FILE_COUNT)
	{
		$files_to_delete = array_splice($files, 0, count($files) - $MAXIMUM_FILE_COUNT);
		for ($i = 0; $i < count($files_to_delete); $i++)
		{
			unlink($files_to_delete[$i][0]);
		}
	}
	print_r($files);
	closedir($directory);

	function sorter($a, $b)
	{
		if ($a[1] == $b[1]) { return 0; }
		else { return ($a[1] < $b[1]) ? -1 : 1; }
	}
?>