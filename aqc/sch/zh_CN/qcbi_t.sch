/* 
================================================================================
檔案代號:qcbi_t
檔案名稱:品質異常申請檢驗單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table qcbi_t
(
qcbient       number(5)      ,/* 企業編號 */
qcbisite       varchar2(10)      ,/* 營運據點 */
qcbidocno       varchar2(20)      ,/* 品質異常單號 */
qcbiseq       number(10,0)      ,/* 行序 */
qcbi001       varchar2(10)      ,/* 檢驗項目 */
qcbi002       varchar2(40)      ,/* 檢驗位置 */
qcbi003       varchar2(10)      ,/* 缺點等級 */
qcbi004       number(20,6)      ,/* 檢驗量 */
qcbi005       number(20,6)      ,/* 不良數 */
qcbi006       varchar2(10)      ,/* 項目判定結果 */
qcbiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcbiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcbiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcbiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcbiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcbiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcbiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcbiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcbiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcbiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcbiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcbiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcbiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcbiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcbiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcbiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcbiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcbiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcbiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcbiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcbiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcbiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcbiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcbiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcbiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcbiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcbiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcbiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcbiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcbiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcbi_t add constraint qcbi_pk primary key (qcbient,qcbidocno,qcbiseq) enable validate;

create unique index qcbi_pk on qcbi_t (qcbient,qcbidocno,qcbiseq);

grant select on qcbi_t to tiptop;
grant update on qcbi_t to tiptop;
grant delete on qcbi_t to tiptop;
grant insert on qcbi_t to tiptop;

exit;
