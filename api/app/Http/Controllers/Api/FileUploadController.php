<?php

namespace App\Http\Controllers\Api;

use Validator;
use App\Models\Marcas;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;

class FileUploadController extends Controller {
   
    public function fileUpload($file, $destinationPath) {
        $extenstion = $file->getClientOriginalExtension();
        $fileName = substr(str_shuffle(str_repeat('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789',5)),0,10).'.'.$extenstion;
        $file->move($destinationPath, $fileName);
        return $fileName;
    }

    public function fileUploadBase64($file, $destinationPath) {

        $file_data = $file; 
        @list($type, $file_data) = explode(';', $file_data);
        @list(, $file_data) = explode(',', $file_data); 

        $extenstion = explode('/',$type)[1];
        $file_name = substr(str_shuffle(str_repeat('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789',5)),0,10).'.'.$extenstion; //generating unique file name; 

        if($file_data!=""){ // storing image in storage/app/public Folder 
            \Storage::disk('public_uploads')->put($destinationPath.'/'.$file_name,base64_decode($file_data)); 
        } 

        return $file_name;
    }
}
