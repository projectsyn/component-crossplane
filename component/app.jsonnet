local kap = import 'lib/kapitan.libjsonnet';
local inv = kap.inventory();
local params = inv.parameters.crossplane;
local argocd = import 'lib/argocd.libjsonnet';
local on_openshift4 = std.member([ 'openshift4', 'oke' ], inv.parameters.facts.distribution);

local ignore_diff_sa = {
  group: '',
  kind: 'ServiceAccount',
  name: '',
  jsonPointers: [ '/imagePullSecrets' ],
};

local ignore_diff_cr = {
  group: 'rbac.authorization.k8s.io',
  kind: 'ClusterRole',
  name: 'crossplane',
  jsonPointers: [ '/rules' ],
};

local app = argocd.App('crossplane', params.namespace) {
  metadata+: {
    finalizers: params.argocd.application.finalizers,
  },
  spec+: {
    ignoreDifferences:
      [ ignore_diff_cr ] +
      if on_openshift4 then
        [ ignore_diff_sa ]
      else
        [],
  },
};

local appPath =
  local project = std.get(std.get(app, 'spec', {}), 'project', 'syn');
  if project == 'syn' then 'apps' else 'apps-%s' % project;

{
  ['%s/crossplane' % appPath]: app,
}
