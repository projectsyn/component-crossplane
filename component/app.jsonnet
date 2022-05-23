local kap = import 'lib/kapitan.libjsonnet';
local inv = kap.inventory();
local params = inv.parameters.crossplane;
local argocd = import 'lib/argocd.libjsonnet';
local on_openshift4 = inv.parameters.facts.distribution == 'openshift4';

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
  spec+: {
    ignoreDifferences:
      [ ignore_diff_cr ] +
      if on_openshift4 then
        [ ignore_diff_sa ]
      else
        [],
  },
};

{
  crossplane: app,
}
