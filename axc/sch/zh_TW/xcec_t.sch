/* 
================================================================================
檔案代號:xcec_t
檔案名稱:成本憑證第二單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xcec_t
(
xcecent       number(5)      ,/* 企業編號 */
xceccomp       varchar2(10)      ,/* 法人組織 */
xcecld       varchar2(5)      ,/* 帳套 */
xcecdocno       varchar2(20)      ,/* 單據編號 */
xcecseq       number(10,0)      ,/* 項次 */
xcec001       varchar2(20)      ,/* 參考單據 */
xcec002       number(10,0)      ,/* 參考單據項次 */
xcec003       varchar2(10)      ,/* 單據類型 */
xcec004       varchar2(40)      ,/* 料件編號 */
xcec005       varchar2(256)      ,/* 特性 */
xcec101       varchar2(24)      ,/* 科目編號 */
xcec102       varchar2(80)      ,/* 摘要 */
xcec103       varchar2(30)      ,/* 成本域 */
xcec110       varchar2(10)      ,/* 原因碼 */
xcec111       varchar2(20)      ,/* 收付款客商 */
xcec112       varchar2(10)      ,/* 客群 */
xcec113       varchar2(10)      ,/* 區域 */
xcec114       varchar2(10)      ,/* 成本中心 */
xcec115       varchar2(10)      ,/* 經營類別 */
xcec116       varchar2(10)      ,/* 通路 */
xcec117       varchar2(10)      ,/* 品類 */
xcec118       varchar2(10)      ,/* 品牌 */
xcec119       varchar2(20)      ,/* 專案號 */
xcec120       varchar2(30)      ,/* WBS */
xcec201       number(20,6)      ,/* 數量 */
xcec202       number(20,6)      ,/* 成本金額(本位幣一) */
xcec202a       number(20,6)      ,/* 成本-材料(本位幣一) */
xcec202b       number(20,6)      ,/* 成本-人工(本位幣一) */
xcec202c       number(20,6)      ,/* 成本-加工(本位幣一) */
xcec202d       number(20,6)      ,/* 成本-制費一(本位幣一) */
xcec202e       number(20,6)      ,/* 成本-制費二(本位幣一) */
xcec202f       number(20,6)      ,/* 成本-制費三(本位幣一) */
xcec202g       number(20,6)      ,/* 成本-制費四(本位幣一) */
xcec202h       number(20,6)      ,/* 成本-制費五(本位幣一) */
xcec212       number(20,6)      ,/* 成本-金額(本位幣二) */
xcec212a       number(20,6)      ,/* 成本-材料(本位幣二) */
xcec212b       number(20,6)      ,/* 成本-人工(本位幣二) */
xcec212c       number(20,6)      ,/* 成本-加工(本位幣二) */
xcec212d       number(20,6)      ,/* 成本-制費一(本位幣二) */
xcec212e       number(20,6)      ,/* 成本-制費二(本位幣二) */
xcec212f       number(20,6)      ,/* 成本-制費三(本位幣二) */
xcec212g       number(20,6)      ,/* 成本-制費四(本位幣二) */
xcec212h       number(20,6)      ,/* 成本-制費五(本位幣二) */
xcec222       number(20,6)      ,/* 成本-金額(本位幣三) */
xcec222a       number(20,6)      ,/* 成本-材料(本位幣三) */
xcec222b       number(20,6)      ,/* 成本-人工(本位幣三) */
xcec222c       number(20,6)      ,/* 成本-加工(本位幣三) */
xcec222d       number(20,6)      ,/* 成本-制費一(本位幣三) */
xcec222e       number(20,6)      ,/* 成本-制費二(本位幣三) */
xcec222f       number(20,6)      ,/* 成本-制費三(本位幣三) */
xcec222g       number(20,6)      ,/* 成本-制費四(本位幣三) */
xcec222h       number(20,6)      ,/* 成本-制費五(本位幣三) */
xcec301       varchar2(20)      ,/* 憑證編號 */
xcec302       number(10,0)      ,/* 憑證項次 */
xcecud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcecud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcecud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcecud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcecud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcecud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcecud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcecud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcecud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcecud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcecud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcecud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcecud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcecud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcecud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcecud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcecud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcecud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcecud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcecud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcecud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcecud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcecud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcecud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcecud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcecud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcecud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcecud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcecud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcecud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xcec107       varchar2(20)      ,/* 人員 */
xcec108       varchar2(10)      ,/* 部門 */
xcec109       varchar2(10)      ,/* 帳款對象 */
xcec121       varchar2(10)      ,/* 自由核算項1 */
xcec122       varchar2(10)      ,/* 自由核算項2 */
xcec123       varchar2(10)      ,/* 自由核算項3 */
xcec124       varchar2(10)      ,/* 自由核算項4 */
xcec125       varchar2(10)      ,/* 自由核算項5 */
xcec126       varchar2(10)      ,/* 自由核算項6 */
xcec127       varchar2(10)      ,/* 自由核算項7 */
xcec128       varchar2(10)      ,/* 自由核算項8 */
xcec129       varchar2(10)      ,/* 自由核算項9 */
xcec130       varchar2(10)      /* 自由核算項10 */
);
alter table xcec_t add constraint xcec_pk primary key (xcecent,xcecld,xcecdocno,xcecseq) enable validate;

create unique index xcec_pk on xcec_t (xcecent,xcecld,xcecdocno,xcecseq);

grant select on xcec_t to tiptop;
grant update on xcec_t to tiptop;
grant delete on xcec_t to tiptop;
grant insert on xcec_t to tiptop;

exit;
