/* 
================================================================================
檔案代號:qcag_t
檔案名稱:C=0檢驗水準計數值樣本代碼檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table qcag_t
(
qcagent       number(5)      ,/* 企業編號 */
qcag001       number(10,0)      ,/* 起始批量 */
qcag002       number(10,0)      ,/* 截止批量 */
qcag003       number(7,3)      ,/* AQL */
qcag004       varchar2(10)      ,/* 級數 */
qcag005       number(5,0)      ,/* 抽樣數 */
qcagownid       varchar2(20)      ,/* 資料所有者 */
qcagowndp       varchar2(10)      ,/* 資料所屬部門 */
qcagcrtid       varchar2(20)      ,/* 資料建立者 */
qcagcrtdp       varchar2(10)      ,/* 資料建立部門 */
qcagcrtdt       timestamp(0)      ,/* 資料創建日 */
qcagmodid       varchar2(20)      ,/* 資料修改者 */
qcagmoddt       timestamp(0)      ,/* 最近修改日 */
qcagstus       varchar2(10)      ,/* 狀態碼 */
qcagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcagud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcag_t add constraint qcag_pk primary key (qcagent,qcag001,qcag002,qcag003,qcag004) enable validate;

create unique index qcag_pk on qcag_t (qcagent,qcag001,qcag002,qcag003,qcag004);

grant select on qcag_t to tiptop;
grant update on qcag_t to tiptop;
grant delete on qcag_t to tiptop;
grant insert on qcag_t to tiptop;

exit;
