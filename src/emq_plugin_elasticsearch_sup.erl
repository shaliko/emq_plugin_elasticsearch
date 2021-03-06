%%%-------------------------------------------------------------------
%% @doc Supervisor for EMQ Elasticsearch plugin
%% @end
%%%-------------------------------------------------------------------
-module(emq_plugin_elasticsearch_sup).
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
  SupFlags = #{strategy => one_for_one, intensity => 1, period => 5},
  ChildSpecs = [#{id => emq_plugin_elasticsearch_logger,
                  start => {emq_plugin_elasticsearch_logger, start_link, []},
                  restart => permanent,
                  shutdown => 5000,
                  type => worker,
                  modules => [emq_plugin_elasticsearch_logger]}],
  {ok, {SupFlags, ChildSpecs}}.
