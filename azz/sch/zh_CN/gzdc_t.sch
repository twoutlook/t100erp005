/* 
================================================================================
檔案代號:gzdc_t
檔案名稱:全域變數定義轉換表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table gzdc_t
(
gzdc001       varchar2(20)      ,/* 程式代碼 */
gzdc002       varchar2(15)      ,/* 表格代碼 */
gzdcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzdcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzdcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzdcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzdcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzdcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzdcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzdcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzdcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzdcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzdcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzdcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzdcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzdcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzdcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzdcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzdcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzdcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzdcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzdcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzdcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzdcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzdcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzdcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzdcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzdcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzdcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzdcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzdcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzdcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzdc_t add constraint gzdc_pk primary key (gzdc001,gzdc002) enable validate;

create unique index gzdc_pk on gzdc_t (gzdc001,gzdc002);

grant select on gzdc_t to tiptop;
grant update on gzdc_t to tiptop;
grant delete on gzdc_t to tiptop;
grant insert on gzdc_t to tiptop;

exit;
