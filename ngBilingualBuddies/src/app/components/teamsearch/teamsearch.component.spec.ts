import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TeamsearchComponent } from './teamsearch.component';

describe('TeamsearchComponent', () => {
  let component: TeamsearchComponent;
  let fixture: ComponentFixture<TeamsearchComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ TeamsearchComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TeamsearchComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
