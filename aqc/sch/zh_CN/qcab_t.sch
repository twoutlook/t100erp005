/* 
================================================================================
檔案代號:qcab_t
檔案名稱:特殊檢驗水準樣本代碼檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table qcab_t
(
qcabstus       varchar2(10)      ,/* 狀態碼 */
qcabent       number(5)      ,/* 企業編號 */
qcab001       number(10,0)      ,/* 起始批量 */
qcab002       number(10,0)      ,/* 截止批量 */
qcab003       varchar2(10)      ,/* 級數 */
qcab004       varchar2(1)      ,/* 樣本編號 */
qcab005       number(5,0)      ,/* no use */
qcab006       number(5,0)      ,/* no use */
qcab007       number(5,0)      ,/* no use */
qcabownid       varchar2(20)      ,/* 資料所有者 */
qcabowndp       varchar2(10)      ,/* 資料所屬部門 */
qcabcrtid       varchar2(20)      ,/* 資料建立者 */
qcabcrtdp       varchar2(10)      ,/* 資料建立部門 */
qcabcrtdt       timestamp(0)      ,/* 資料創建日 */
qcabmodid       varchar2(20)      ,/* 資料修改者 */
qcabmoddt       timestamp(0)      ,/* 最近修改日 */
qcabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcab_t add constraint qcab_pk primary key (qcabent,qcab001,qcab002,qcab003,qcab004) enable validate;

create unique index qcab_pk on qcab_t (qcabent,qcab001,qcab002,qcab003,qcab004);

grant select on qcab_t to tiptop;
grant update on qcab_t to tiptop;
grant delete on qcab_t to tiptop;
grant insert on qcab_t to tiptop;

exit;
