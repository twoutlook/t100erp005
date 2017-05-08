/* 
================================================================================
檔案代號:mmck_t
檔案名稱:換贈生效時段申請單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmck_t
(
mmckent       number(5)      ,/* 企業編號 */
mmcksite       varchar2(10)      ,/* 營運據點 */
mmckunit       varchar2(10)      ,/* 應用組織 */
mmckdocno       varchar2(20)      ,/* 單據編號 */
mmck001       varchar2(30)      ,/* 活動規則編號 */
mmck002       varchar2(10)      ,/* 卡種編號 */
mmck003       number(10,0)      ,/* 時段序 */
mmck004       date      ,/* 開始日期 */
mmck005       date      ,/* 結束日期 */
mmck006       varchar2(8)      ,/* 每日開始時間 */
mmck007       varchar2(8)      ,/* 每日結束時間 */
mmck008       varchar2(10)      ,/* 固定日期 */
mmck009       varchar2(1)      ,/* 固定星期 */
mmckacti       varchar2(1)      ,/* 有效 */
mmckud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmckud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmckud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmckud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmckud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmckud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmckud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmckud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmckud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmckud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmckud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmckud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmckud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmckud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmckud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmckud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmckud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmckud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmckud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmckud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmckud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmckud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmckud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmckud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmckud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmckud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmckud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmckud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmckud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmckud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmck_t add constraint mmck_pk primary key (mmckent,mmckdocno,mmck003) enable validate;

create unique index mmck_pk on mmck_t (mmckent,mmckdocno,mmck003);

grant select on mmck_t to tiptop;
grant update on mmck_t to tiptop;
grant delete on mmck_t to tiptop;
grant insert on mmck_t to tiptop;

exit;
