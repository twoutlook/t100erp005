/* 
================================================================================
檔案代號:bmff_t
檔案名稱:ECN多產出主件檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmff_t
(
bmffent       number(5)      ,/* 企業編號 */
bmffsite       varchar2(10)      ,/* 營運據點 */
bmffdocno       varchar2(20)      ,/* ECN單號 */
bmff002       number(10,0)      ,/* 項次 */
bmff003       varchar2(10)      ,/* 變更方式 */
bmff004       varchar2(40)      ,/* 產出料號 */
bmff005       number(20,6)      ,/* 數量 */
bmff006       varchar2(10)      ,/* 單位 */
bmff007       date      ,/* 生效日期 */
bmff008       date      ,/* 失效日期 */
bmffud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmffud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmffud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmffud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmffud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmffud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmffud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmffud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmffud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmffud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmffud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmffud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmffud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmffud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmffud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmffud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmffud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmffud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmffud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmffud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmffud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmffud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmffud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmffud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmffud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmffud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmffud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmffud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmffud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmffud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmff_t add constraint bmff_pk primary key (bmffent,bmffsite,bmffdocno,bmff002) enable validate;

create unique index bmff_pk on bmff_t (bmffent,bmffsite,bmffdocno,bmff002);

grant select on bmff_t to tiptop;
grant update on bmff_t to tiptop;
grant delete on bmff_t to tiptop;
grant insert on bmff_t to tiptop;

exit;
