import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'meetupSearch'
})
export class MeetupSearchPipe implements PipeTransform {

  transform(value: unknown, ...args: unknown[]): unknown {
    return null;
  }

}
