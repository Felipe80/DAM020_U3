<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class AuthKey
{
    private $KEY = 'fnBVCwUNBOFKmArIqYXTrJ4dFwPmRB0R';
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        $key = $request->header('APP_KEY');
        if($key != $this->KEY){
            return response()->json(['message'=>'Necesita una llave para acceder a este recurso'],401);
        }
        return $next($request);
    }
}
