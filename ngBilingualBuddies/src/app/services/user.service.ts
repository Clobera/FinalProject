import { environment } from './../../environments/environment.development';
import { User } from './../models/user';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  url = environment.baseUrl + "/user";
  constructor(private http : HttpClient) { }



}
