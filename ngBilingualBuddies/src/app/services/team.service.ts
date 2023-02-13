import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Team } from '../models/team';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class TeamService {


  url = environment.baseUrl + "api/teams";
  constructor(private http : HttpClient, private auth : AuthService) { }

  index(): Observable<Team[]> {
    let httpOptions = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-with': 'XMLHttpRequest',
      }
    };
    return this.http.get<Team[]>(this.url, httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error(
              ' Error retrieving Teams: ' + err
            )
        );
      })
    );
  }

  show(id: number): Observable<Team>{
    return this.http.get<Team>(`${this.url}/${id}`, this.getHttpOptions()).pipe(
      catchError((err: any) =>{
        console.log(err);
        return throwError(
          () =>
          new Error('Error retrieving Team: ' + err
          )
        )
      })
    )
  }

  showByUsername(username: String): Observable<Team>{
    return this.http.get<Team>(`${this.url}/myTeam`, this.getHttpOptions()).pipe(
      catchError((err: any) =>{
        console.log(err);
        return throwError(
          () =>
          new Error('Error retrieving Team: ' + err
          )
        )
      })
    )
  }

  create(team: Team): Observable<Team>{
    return this.http.post<Team>(this.url, team, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('Error creating team: ' + err)
        );
      })
    );
  }

  update(team: Team): Observable<Team>{
    return this.http.put<Team>(`${this.url}/${team.id}`, team, this.getHttpOptions()).pipe(
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
