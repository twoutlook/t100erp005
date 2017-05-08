/* 
================================================================================
檔案代號:rtdd_t
檔案名稱:生命週期歷史檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtdd_t
(
rtddent       number(5)      ,/* 企業編號 */
rtddunit       varchar2(10)      ,/* 制定組織 */
rtddsite       varchar2(10)      ,/* 營運組織 */
rtdd001       varchar2(20)      ,/* 生命週期類型 */
rtdd002       varchar2(40)      ,/* 商品/供應商編號 */
rtdd003       number(10,0)      ,/* 變更序號 */
rtdd004       varchar2(10)      ,/* 程式編號 */
rtdd005       varchar2(20)      ,/* 單據編號 */
rtdd006       varchar2(10)      ,/* 原生命周期 */
rtdd007       varchar2(10)      ,/* 新生命週期 */
rtdd008       varchar2(20)      ,/* 操作人員 */
rtdd009       date      ,/* 操作日期 */
rtdd010       varchar2(8)      ,/* 操作時間 */
rtdd011       varchar2(1)      ,/* 自動轉換否 */
rtdd012       number(10,0)      ,/* 轉換天數 */
rtdd013       date      ,/* 轉換日期 */
rtddud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtddud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtddud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtddud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtddud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtddud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtddud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtddud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtddud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtddud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtddud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtddud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtddud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtddud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtddud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtddud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtddud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtddud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtddud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtddud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtddud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtddud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtddud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtddud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtddud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtddud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtddud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtddud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtddud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtddud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtdd014       varchar2(10)      /* 供應商編號 */
);
alter table rtdd_t add constraint rtdd_pk primary key (rtddent,rtddsite,rtdd001,rtdd002,rtdd003,rtdd014) enable validate;

create unique index rtdd_pk on rtdd_t (rtddent,rtddsite,rtdd001,rtdd002,rtdd003,rtdd014);

grant select on rtdd_t to tiptop;
grant update on rtdd_t to tiptop;
grant delete on rtdd_t to tiptop;
grant insert on rtdd_t to tiptop;

exit;
