/* 
================================================================================
檔案代號:rtaz_t
檔案名稱:程式組織應用設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtaz_t
(
rtazent       number(5)      ,/* 企業代碼 */
rtaz001       varchar2(20)      ,/* 程式代號 */
rtazownid       varchar2(20)      ,/* 資料所有者 */
rtazowndp       varchar2(10)      ,/* 資料所屬部門 */
rtazcrtid       varchar2(20)      ,/* 資料建立者 */
rtazcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtazcrtdt       timestamp(0)      ,/* 資料創建日 */
rtazmodid       varchar2(20)      ,/* 資料修改者 */
rtazmoddt       timestamp(0)      ,/* 最近修改日 */
rtazstus       varchar2(10)      ,/* 狀態碼 */
rtazud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtazud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtazud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtazud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtazud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtazud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtazud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtazud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtazud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtazud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtazud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtazud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtazud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtazud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtazud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtazud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtazud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtazud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtazud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtazud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtazud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtazud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtazud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtazud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtazud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtazud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtazud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtazud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtazud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtazud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtaz_t add constraint rtaz_pk primary key (rtazent,rtaz001) enable validate;

create unique index rtaz_pk on rtaz_t (rtazent,rtaz001);

grant select on rtaz_t to tiptop;
grant update on rtaz_t to tiptop;
grant delete on rtaz_t to tiptop;
grant insert on rtaz_t to tiptop;

exit;
