/* 
================================================================================
檔案代號:mhbf_t
檔案名稱:鋪位場地明細資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mhbf_t
(
mhbfent       number(5)      ,/* 企業編號 */
mhbfsite       varchar2(10)      ,/* 營運組織 */
mhbfunit       varchar2(10)      ,/* 制定組織 */
mhbf001       varchar2(20)      ,/* 鋪位編號 */
mhbf002       varchar2(20)      ,/* 場地編號 */
mhbf003       number(5,0)      ,/* 場地版本 */
mhbf004       varchar2(10)      ,/* 樓棟編號 */
mhbf005       varchar2(10)      ,/* 樓層編號 */
mhbf006       varchar2(10)      ,/* 區域編號 */
mhbf007       number(20,6)      ,/* 建築面積 */
mhbf008       number(20,6)      ,/* 測量面積 */
mhbf009       number(20,6)      ,/* 經營面積 */
mhbfstus       varchar2(10)      ,/* 狀態碼 */
mhbfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mhbfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mhbfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mhbfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mhbfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mhbfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mhbfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mhbfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mhbfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mhbfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mhbfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mhbfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mhbfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mhbfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mhbfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mhbfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mhbfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mhbfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mhbfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mhbfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mhbfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mhbfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mhbfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mhbfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mhbfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mhbfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mhbfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mhbfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mhbfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mhbfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mhbf_t add constraint mhbf_pk primary key (mhbfent,mhbf001,mhbf002) enable validate;

create unique index mhbf_pk on mhbf_t (mhbfent,mhbf001,mhbf002);

grant select on mhbf_t to tiptop;
grant update on mhbf_t to tiptop;
grant delete on mhbf_t to tiptop;
grant insert on mhbf_t to tiptop;

exit;
