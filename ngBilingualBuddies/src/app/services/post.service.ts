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
  constructor(private http : HttpClient, private auth : AuthService) { }

  index(): Observable<Post[]> {
    let httpOptions = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-with': 'XMLHttpRequest',
      }
    };
    return this.http.get<Post[]>(this.url, this.getHttpOptions()).pipe(
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

  show(id: number): Observable<Post>{
    return this.http.get<Post>(`${this.url}/${id}`, this.getHttpOptions()).pipe(
      catchError((err: any) =>{
        console.log(err);
        return throwError(
          () =>
          new Error('PostService.show(): error retrieving post: ' + err)
        );
      })
    );
  }

  update(post: Post, id: number): Observable<Post>{
    return this.http.put<Post>(`${this.url}/${id}`, post, this.getHttpOptions()).pipe(
      catchError((err: any) =>{
        console.log(err);
        return throwError(
          () => new Error('PostService.update(): error updating post: ' + err)
        );
      })
    );
  }

  create(post: Post): Observable<Post>{
    return this.http.post<Post>(`${this.url}`, post, this.getHttpOptions()).pipe(
      catchError((err: any) =>{
        console.log(err);
        return throwError(
          () => new Error('PostService.create(): error creating post: ' + err)
        );
      })
    );
  }

  destroy(id: number, post: Post): Observable<void>{
    return this.http.delete<void>(`${this.url}/${id}`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('PostService.destroy(): error deleting Post: ' + err)
        );
      })
    );
  }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }
}
