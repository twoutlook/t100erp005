/* 
================================================================================
檔案代號:xceb_t
檔案名稱:成本憑證第一單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xceb_t
(
xcebent       number(5)      ,/* 企業編號 */
xcebcomp       varchar2(10)      ,/* 法人組織 */
xcebld       varchar2(5)      ,/* 帳套 */
xcebdocno       varchar2(20)      ,/* 單據編號 */
xcebseq       number(10,0)      ,/* 項次 */
xceb001       varchar2(20)      ,/* 參考單據編號 */
xceb002       number(10,0)      ,/* 參考單據項次 */
xceb003       varchar2(10)      ,/* 單據類型 */
xceb004       varchar2(40)      ,/* 料件編號 */
xceb005       varchar2(256)      ,/* 特性 */
xceb101       varchar2(24)      ,/* 科目編號 */
xceb102       varchar2(80)      ,/* 摘要 */
xceb103       varchar2(30)      ,/* 成本域 */
xceb110       varchar2(20)      ,/* 原因碼 */
xceb111       varchar2(20)      ,/* 交易對象 */
xceb112       varchar2(10)      ,/* 客群 */
xceb113       varchar2(10)      ,/* 區域 */
xceb114       varchar2(10)      ,/* 成本中心 */
xceb115       varchar2(10)      ,/* 經營類別 */
xceb116       varchar2(10)      ,/* 渠道 */
xceb117       varchar2(10)      ,/* 品類 */
xceb118       varchar2(10)      ,/* 品牌 */
xceb119       varchar2(20)      ,/* 項目號 */
xceb120       varchar2(30)      ,/* WBS */
xceb201       number(20,6)      ,/* 數量 */
xceb202       number(20,6)      ,/* 成本金額(本位幣一) */
xceb202a       number(20,6)      ,/* 成本-材料(本位幣一) */
xceb202b       number(20,6)      ,/* 成本-人工(本位幣一) */
xceb202c       number(20,6)      ,/* 成本-加工(本位幣一) */
xceb202d       number(20,6)      ,/* 成本-制費一(本位幣一) */
xceb202e       number(20,6)      ,/* 成本-制費二(本位幣一) */
xceb202f       number(20,6)      ,/* 成本-制費三(本位幣一) */
xceb202g       number(20,6)      ,/* 成本-制費四(本位幣一) */
xceb202h       number(20,6)      ,/* 成本-制費五(本位幣一) */
xceb212       number(20,6)      ,/* 成本金額(本位幣二) */
xceb212a       number(20,6)      ,/* 成本-材料(本位幣二) */
xceb212b       number(20,6)      ,/* 成本-人工(本位幣二) */
xceb212c       number(20,6)      ,/* 成本-加工(本位幣二) */
xceb212d       number(20,6)      ,/* 成本-制費一(本位幣二) */
xceb212e       number(20,6)      ,/* 成本-制費二(本位幣二) */
xceb212f       number(20,6)      ,/* 成本-制費三(本位幣二) */
xceb212g       number(20,6)      ,/* 成本-制費四(本位幣二) */
xceb212h       number(20,6)      ,/* 成本-制費五(本位幣二) */
xceb222       number(20,6)      ,/* 成本金額(本位幣三) */
xceb222a       number(20,6)      ,/* 成本-材料(本位幣三) */
xceb222b       number(20,6)      ,/* 成本-人工(本位幣三) */
xceb222c       number(20,6)      ,/* 成本-加工(本位幣三) */
xceb222d       number(20,6)      ,/* 成本-制費一(本位幣三) */
xceb222e       number(20,6)      ,/* 成本-制費二(本位幣三) */
xceb222f       number(20,6)      ,/* 成本-制費三(本位幣三) */
xceb222g       number(20,6)      ,/* 成本-制費四(本位幣三) */
xceb222h       number(20,6)      ,/* 成本-制費五(本位幣三) */
xceb301       varchar2(20)      ,/* 憑證編號 */
xceb302       number(10,0)      ,/* 憑證項次 */
xcebud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcebud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcebud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcebud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcebud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcebud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcebud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcebud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcebud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcebud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcebud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcebud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcebud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcebud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcebud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcebud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcebud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcebud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcebud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcebud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcebud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcebud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcebud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcebud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcebud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcebud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcebud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcebud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcebud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcebud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xceb107       varchar2(20)      ,/* 人員 */
xceb108       varchar2(10)      ,/* 部門 */
xceb109       varchar2(10)      ,/* 帳款對象 */
xceb121       varchar2(10)      ,/* 自由核算項1 */
xceb122       varchar2(10)      ,/* 自由核算項2 */
xceb123       varchar2(10)      ,/* 自由核算項3 */
xceb124       varchar2(10)      ,/* 自由核算項4 */
xceb125       varchar2(10)      ,/* 自由核算項5 */
xceb126       varchar2(10)      ,/* 自由核算項6 */
xceb127       varchar2(10)      ,/* 自由核算項7 */
xceb128       varchar2(10)      ,/* 自由核算項8 */
xceb129       varchar2(10)      ,/* 自由核算項9 */
xceb130       varchar2(10)      /* 自由核算項10 */
);
alter table xceb_t add constraint xceb_pk primary key (xcebent,xcebld,xcebdocno,xcebseq) enable validate;

create unique index xceb_pk on xceb_t (xcebent,xcebld,xcebdocno,xcebseq);

grant select on xceb_t to tiptop;
grant update on xceb_t to tiptop;
grant delete on xceb_t to tiptop;
grant insert on xceb_t to tiptop;

exit;
