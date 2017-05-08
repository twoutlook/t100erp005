/* 
================================================================================
檔案代號:mhbd_t
檔案名稱:鋪位申請場地明細資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mhbd_t
(
mhbdent       number(5)      ,/* 企業編號 */
mhbdsite       varchar2(10)      ,/* 營運組織 */
mhbdunit       varchar2(10)      ,/* 應用組織 */
mhbddocno       varchar2(20)      ,/* 單號 */
mhbd000       varchar2(10)      ,/* 類型 */
mhbd001       varchar2(20)      ,/* 鋪位編號 */
mhbd002       varchar2(20)      ,/* 場地編號 */
mhbd003       number(5,0)      ,/* 場地版本 */
mhbd004       varchar2(10)      ,/* 樓棟編號 */
mhbd005       varchar2(10)      ,/* 樓層編號 */
mhbd006       varchar2(10)      ,/* 區域編號 */
mhbd007       number(20,6)      ,/* 建築面積 */
mhbd008       number(20,6)      ,/* 測量面積 */
mhbd009       number(20,6)      ,/* 經營面積 */
mhbdacti       varchar2(1)      ,/* 資料有效碼 */
mhbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mhbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mhbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mhbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mhbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mhbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mhbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mhbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mhbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mhbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mhbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mhbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mhbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mhbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mhbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mhbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mhbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mhbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mhbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mhbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mhbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mhbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mhbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mhbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mhbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mhbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mhbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mhbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mhbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mhbdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mhbd_t add constraint mhbd_pk primary key (mhbdent,mhbddocno,mhbd002) enable validate;

create unique index mhbd_pk on mhbd_t (mhbdent,mhbddocno,mhbd002);

grant select on mhbd_t to tiptop;
grant update on mhbd_t to tiptop;
grant delete on mhbd_t to tiptop;
grant insert on mhbd_t to tiptop;

exit;
