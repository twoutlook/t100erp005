/* 
================================================================================
檔案代號:oobg_t
檔案名稱:傳票單別相關設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oobg_t
(
oobgent       number(5)      ,/* 企業編號 */
oobg001       varchar2(5)      ,/* 參照表編號 */
oobg002       varchar2(5)      ,/* 單據別 */
oobg003       varchar2(1)      ,/* 轉帳性質 */
oobg004       varchar2(24)      ,/* 收支科目 */
oobgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oobgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oobgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oobgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oobgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oobgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oobgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oobgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oobgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oobgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oobgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oobgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oobgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oobgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oobgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oobgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oobgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oobgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oobgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oobgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oobgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oobgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oobgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oobgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oobgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oobgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oobgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oobgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oobgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oobgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oobg_t add constraint oobg_pk primary key (oobgent,oobg001,oobg002) enable validate;

create unique index oobg_pk on oobg_t (oobgent,oobg001,oobg002);

grant select on oobg_t to tiptop;
grant update on oobg_t to tiptop;
grant delete on oobg_t to tiptop;
grant insert on oobg_t to tiptop;

exit;
