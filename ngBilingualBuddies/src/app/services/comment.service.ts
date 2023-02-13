import { Comment } from './../models/comment';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Team } from '../models/team';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class CommentService {


  url = environment.baseUrl + "api/teams";
  constructor(private http : HttpClient, private auth : AuthService) { }

  index(): Observable<Comment[]> {
    let httpOptions = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-with': 'XMLHttpRequest',
      }
    };
    return this.http.get<Comment[]>(this.url, httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error(
              ' Error retrieving Comments: ' + err
            )
        );
      })
    );
  }

  show(id: number): Observable<Comment>{
    return this.http.get<Comment>(`${this.url}/${id}`, this.getHttpOptions()).pipe(
      catchError((err: any) =>{
        console.log(err);
        return throwError(
          () =>
          new Error('Error retrieving Comment: ' + err
          )
        )
      })
    )
  }

  create(comment: Comment): Observable<Comment>{
    return this.http.post<Comment>(this.url, comment, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('Error creating Comment: ' + err)
        );
      })
    );
  }

  update(comment: Comment): Observable<Comment>{
    return this.http.put<Comment>(`${this.url}/${comment.id}`, comment, this.getHttpOptions()).pipe(
      catchError((err: any) =>{
        console.log(err);
        return throwError(
          () => new Error('Error updating team: ' + err)
        );
      })
    );
  }

  destroy(id: number): Observable<void>{
    return this.http.delete<void>(`${this.url}/${id}`, this.getHttpOptions()).pipe(
      catchError((err: any) =>{
        console.log(err);
        return throwError(
          () => new Error('Error deleting team: ' + err)
        )
      })
    )
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

