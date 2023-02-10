import { Language } from './../models/language';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { catchError, Observable, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class LanguageService {
  url = environment.baseUrl + "languages"

  index(): Observable<Language[]> {
    return this.httpClient.get<Language[]>(this.url).pipe(
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

  constructor(private httpClient : HttpClient) { }
}
