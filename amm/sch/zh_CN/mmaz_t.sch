/* 
================================================================================
檔案代號:mmaz_t
檔案名稱:會員卡領用申請單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmaz_t
(
mmazent       number(5)      ,/* 企業編號 */
mmazsite       varchar2(10)      ,/* 營運據點 */
mmazunit       varchar2(10)      ,/* 應用組織 */
mmazdocno       varchar2(20)      ,/* 單據編號 */
mmazseq       number(10,0)      ,/* 項次 */
mmaz000       varchar2(10)      ,/* 資料類型 */
mmaz001       varchar2(10)      ,/* 卡種編號 */
mmaz002       varchar2(10)      ,/* 領出組織 */
mmaz003       varchar2(10)      ,/* 領出庫位 */
mmaz004       varchar2(10)      ,/* 領用組織 */
mmaz005       varchar2(10)      ,/* 領用庫位 */
mmaz006       number(10,0)      ,/* 申請數量 */
mmaz007       number(10,0)      ,/* 確認數量 */
mmaz008       varchar2(20)      ,/* 會員卡調撥單號 */
mmaz009       number(10,0)      ,/* 會員卡調撥項次 */
mmazud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmazud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmazud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmazud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmazud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmazud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmazud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmazud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmazud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmazud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmazud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmazud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmazud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmazud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmazud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmazud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmazud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmazud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmazud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmazud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmazud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmazud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmazud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmazud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmazud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmazud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmazud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmazud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmazud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmazud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmaz_t add constraint mmaz_pk primary key (mmazent,mmazdocno,mmazseq) enable validate;

create unique index mmaz_pk on mmaz_t (mmazent,mmazdocno,mmazseq);

grant select on mmaz_t to tiptop;
grant update on mmaz_t to tiptop;
grant delete on mmaz_t to tiptop;
grant insert on mmaz_t to tiptop;

exit;
