import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Country } from '../models/country';
import { Language } from '../models/language';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class CountryService {

  url = environment.baseUrl + "api/countries"


  index(): Observable<Country[]> {
    let httpOptions = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-with': 'XMLHttpRequest',
      }
    };
    return this.httpClient.get<Country[]>(this.url, httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error(
              'LanguageService.index(): error retrieving Languages: ' + err
            )
        );
      })
    );
  }

  indexNoCred(): Observable<Country[]> {
    let httpOptions = {
      headers: {
        Authorization: 'Basic ' + 'YWRtaW46d29tYmF0MQ==',
        'X-Requested-with': 'XMLHttpRequest',
      }
    };
    return this.httpClient.get<Country[]>(this.url, httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error(
              'LanguageService.index(): error retrieving Languages: ' + err
            )
        );
      })
    );
  }

  constructor(private httpClient : HttpClient, private auth : AuthService) { }
}
