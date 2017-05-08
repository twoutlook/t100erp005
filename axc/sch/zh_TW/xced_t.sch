/* 
================================================================================
檔案代號:xced_t
檔案名稱:成本憑證第三單身檔(在製人工費用科目設定)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xced_t
(
xcedent       number(5)      ,/* 企業編號 */
xcedcomp       varchar2(10)      ,/* 法人組織 */
xcedld       varchar2(5)      ,/* 帳套 */
xceddocno       varchar2(20)      ,/* 單據編號 */
xcedseq       number(10,0)      ,/* 項次 */
xced001       varchar2(20)      ,/* 在製科目分類 */
xced101       varchar2(24)      ,/* 科目編號 */
xced102       varchar2(255)      ,/* 摘要 */
xced110       varchar2(10)      ,/* 原因碼 */
xced111       varchar2(10)      ,/* 收付款客商 */
xced112       varchar2(10)      ,/* 客群 */
xced113       varchar2(10)      ,/* 區域 */
xced114       varchar2(10)      ,/* 成本中心 */
xced115       varchar2(10)      ,/* 經營類別 */
xced116       varchar2(10)      ,/* 通路 */
xced117       varchar2(10)      ,/* 品類 */
xced118       varchar2(10)      ,/* 品牌 */
xced119       varchar2(20)      ,/* 專案編號 */
xced120       varchar2(30)      ,/* WBS */
xced202       number(20,6)      ,/* 成本金額(本位幣一) */
xced212       number(20,6)      ,/* 成本金額(本位幣二) */
xced222       number(20,6)      ,/* 成本金額(本位幣三) */
xced301       varchar2(20)      ,/* 憑證編號 */
xced302       number(10,0)      ,/* 憑證項次 */
xcedud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcedud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcedud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcedud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcedud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcedud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcedud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcedud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcedud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcedud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcedud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcedud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcedud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcedud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcedud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcedud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcedud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcedud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcedud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcedud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcedud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcedud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcedud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcedud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcedud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcedud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcedud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcedud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcedud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcedud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xced107       varchar2(20)      ,/* 人員 */
xced108       varchar2(10)      ,/* 部門 */
xced109       varchar2(10)      ,/* 帳款對象 */
xced121       varchar2(10)      ,/* 自由核算項1 */
xced122       varchar2(10)      ,/* 自由核算項2 */
xced123       varchar2(10)      ,/* 自由核算項3 */
xced124       varchar2(10)      ,/* 自由核算項4 */
xced125       varchar2(10)      ,/* 自由核算項5 */
xced126       varchar2(10)      ,/* 自由核算項6 */
xced127       varchar2(10)      ,/* 自由核算項7 */
xced128       varchar2(10)      ,/* 自由核算項8 */
xced129       varchar2(10)      ,/* 自由核算項9 */
xced130       varchar2(10)      /* 自由核算項10 */
);
alter table xced_t add constraint xced_pk primary key (xcedent,xcedld,xceddocno,xcedseq) enable validate;

create unique index xced_pk on xced_t (xcedent,xcedld,xceddocno,xcedseq);

grant select on xced_t to tiptop;
grant update on xced_t to tiptop;
grant delete on xced_t to tiptop;
grant insert on xced_t to tiptop;

exit;
