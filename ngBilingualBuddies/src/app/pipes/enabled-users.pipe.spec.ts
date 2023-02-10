import { EnabledUsersPipe } from './enabled-users.pipe';

describe('EnabledUsersPipe', () => {
  it('create an instance', () => {
    const pipe = new EnabledUsersPipe();
    expect(pipe).toBeTruthy();
  });
});
