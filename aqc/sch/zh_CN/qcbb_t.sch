/* 
================================================================================
檔案代號:qcbb_t
檔案名稱:品質檢驗批序號檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table qcbb_t
(
qcbbent       number(5)      ,/* 企業編號 */
qcbbsite       varchar2(10)      ,/* 營運據點 */
qcbbdocno       varchar2(20)      ,/* 單號 */
qcbb001       varchar2(30)      ,/* 庫存批號 */
qcbb002       varchar2(30)      ,/* 製造批號 */
qcbb003       varchar2(30)      ,/* 製造序號 */
qcbb004       number(20,6)      ,/* 數量 */
qcbb005       varchar2(1)      ,/* 抽驗否 */
qcbb006       varchar2(10)      ,/* 檢驗結果 */
qcbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcbbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcbb_t add constraint qcbb_pk primary key (qcbbent,qcbbdocno,qcbb001,qcbb002,qcbb003) enable validate;

create unique index qcbb_pk on qcbb_t (qcbbent,qcbbdocno,qcbb001,qcbb002,qcbb003);

grant select on qcbb_t to tiptop;
grant update on qcbb_t to tiptop;
grant delete on qcbb_t to tiptop;
grant insert on qcbb_t to tiptop;

exit;
