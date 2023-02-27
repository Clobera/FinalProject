import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'enabledMeetups'
})
export class EnabledMeetupsPipe implements PipeTransform {

  transform(value: unknown, ...args: unknown[]): unknown {
    return null;
  }

}
