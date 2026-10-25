from sqlalchemy.orm import scoped_session


class SafeScopedSession(scoped_session):
    # Sessions are thread-local and closed after each call, so a session still in a transaction when requested again
    # belongs to a call that failed half way. Roll it back, otherwise every later query on that thread fails.
    def __call__(self, **kw):
        session = super().__call__(**kw)
        if session.in_transaction():
            session.rollback()
        return session
