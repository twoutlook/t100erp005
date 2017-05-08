/* 
================================================================================
檔案代號:fmco_t
檔案名稱:融資費用檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmco_t
(
fmcoent       number(5)      ,/* 企業代碼 */
fmcodocno       varchar2(20)      ,/* 融資合同編號 */
fmcoseq       number(10,0)      ,/* 融資合同項次 */
fmcoseq2       number(10,0)      ,/* 項次 */
fmco001       varchar2(1)      ,/* 費用種類 */
fmco002       varchar2(10)      ,/* 幣別 */
fmco003       number(15,3)      ,/* 費率 */
fmco004       number(20,6)      ,/* 金額 */
fmco005       varchar2(20)      ,/* LC票號 */
fmcoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmcoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmcoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmcoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmcoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmcoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmcoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmcoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmcoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmcoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmcoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmcoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmcoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmcoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmcoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmcoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmcoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmcoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmcoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmcoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmcoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmcoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmcoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmcoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmcoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmcoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmcoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmcoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmcoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmcoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmco_t add constraint fmco_pk primary key (fmcoent,fmcodocno,fmcoseq,fmcoseq2) enable validate;

create unique index fmco_pk on fmco_t (fmcoent,fmcodocno,fmcoseq,fmcoseq2);

grant select on fmco_t to tiptop;
grant update on fmco_t to tiptop;
grant delete on fmco_t to tiptop;
grant insert on fmco_t to tiptop;

exit;
