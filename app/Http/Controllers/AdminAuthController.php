<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\Admin;
use Illuminate\Support\Facades\Auth;


class AdminAuthController extends Controller
{
  public function login(Request $request)
{
    \Log::info('Login metodu çağrıldı');
    $credentials = $request->only(['email', 'password']);
    try {
        if (!$token = Auth::guard('api')->attempt($credentials)) {
            \Log::warning('Kimlik doğrulama başarısız');
            return response()->json(['message' => 'Bilgiler yanlış'], 401);
        }
        return response()->json([
            'token' => $token,
            'admin' => Auth::guard('api')->user()
        ]);
    } catch (\Exception $e) {
        \Log::error('Login sırasında hata: '.$e->getMessage());
        return response()->json(['error' => 'Sunucu hatası'], 500);
    }
}


    public function me()
    {
        return response()->json(Auth::guard('api')->user());
    }
}
