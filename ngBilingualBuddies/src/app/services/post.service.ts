import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Post } from '../models/post';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class PostService {

  url = environment.baseUrl + "api/posts";
  constructor(private httpClient : HttpClient, private auth : AuthService) { }

  index(): Observable<Post[]> {
    let httpOptions = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-with': 'XMLHttpRequest',
      }
    };
    return this.httpClient.get<Post[]>(this.url, httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error(
              'PostService.index(): error retrieving Posts: ' + err
            )
        );
      })
    );
  }
}
