<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function login(Request $request){
        $credenciales = $request->only('email','password');
        if(!Auth::attempt($credenciales)){          
            return response(['message'=>'Fail']);
        }
        $accessToken = Auth::user()->createToken('authToken')->accessToken;
        return response([
            'user'=>Auth::user(),
            'access_token'=>$accessToken
        ]);
    }
}
