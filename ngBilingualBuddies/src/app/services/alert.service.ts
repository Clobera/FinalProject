import { AuthService } from 'src/app/services/auth.service';
import { Injectable, Pipe } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { Observable, catchError, throwError } from 'rxjs';
import { Alert } from '../models/alert';


@Injectable({
  providedIn: 'root'
})
export class AlertService {


  url = environment.baseUrl + "api/alerts"
  constructor(private http: HttpClient, private auth: AuthService) { }

  index(): Observable<Alert[]>{
    let httpOptions = {
        headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-with': 'XMLHttpRequest',
    }
  };

  return this.http.get<Alert[]>(this.url, httpOptions).pipe(
    catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error(
          'AlertService.index(): error retrieving Alerts: ' + err
        )
      );
    })
  );
  }
  show(id: number): Observable<Alert>{
    return this.http.get<Alert>(`${this.url}/${id}`, this.getHttpOptions()).pipe(
      catchError((err: any) =>{
        console.log(err);
        return throwError(
          () =>
          new Error('PostService.show(): error retrieving post: ' + err)
        );
      })
    );
  }

  create(alert: Alert): Observable<Alert>{
    return this.http.post<Alert>(`${this.url}`, alert, this.getHttpOptions()).pipe(
      catchError((err: any) =>{
        console.log(err);
        return throwError(
          () => new Error('AlertService.create(): error creating alert: ' + err)
        );
      })
    );
  }

  destroy(id: number, alert: Alert): Observable<void>{
    return this.http.delete<void>(`${this.url}/${id}`, this.getHttpOptions()).pipe(
      catchError((err: any) =>{
        console.log(err);
        return throwError(
          () => new Error('AlertService.destroy(): error deleting alert: ' + err)
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

