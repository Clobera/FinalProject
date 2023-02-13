import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Meetup } from '../models/meetup';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class MeetupService {

  url = environment.baseUrl + "api/meetups";
  constructor(private httpClient : HttpClient, private auth : AuthService) { }

  index(): Observable<Meetup[]> {
    let httpOptions = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-with': 'XMLHttpRequest',
      }
    };
    return this.httpClient.get<Meetup[]>(this.url, httpOptions).pipe(
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

  show(name: String): Observable<Meetup>{
    return this.httpClient.get<Meetup>(`${this.url}/${name}`, this.getHttpOptions()).pipe(
      catchError((err: any) =>{
        console.log(err);
        return throwError(
          () =>
          new Error('MeetupService.show(): error retrieving meetup: ' + err)
        );
      })
    );
  }

  create(meetup: Meetup): Observable<Meetup>{
    return this.httpClient.post<Meetup>(`${this.url}`, meetup, this.getHttpOptions()).pipe(
      catchError((err: any) =>{
        console.log(err);
        return throwError(
          () => new Error('MeetupService.create(): error creating meetup: ' + err)
        );
      })
    );
  }

  update(meetup: Meetup, name: String): Observable<Meetup>{
    return this.httpClient.put<Meetup>(`${this.url}/${name}`, meetup, this.getHttpOptions()).pipe(
      catchError((err: any) =>{
        console.log(err);
        return throwError(
          () => new Error('MeetupService.update(): error updating meetup: ' + err)
        );
      })
    );
  }

  destroy(meetup: Meetup, name: String): Observable<void>{
    return this.httpClient.delete<void>(`${this.url}/${name}`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('MeetupService.destroy(): error deleting Meetup: ' + err)
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

