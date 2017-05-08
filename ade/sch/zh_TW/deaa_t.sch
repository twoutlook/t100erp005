/* 
================================================================================
檔案代號:deaa_t
檔案名稱:銀行卡第三方卡對帳差異明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table deaa_t
(
deaaent       number(5)      ,/* 企業編號 */
deaasite       varchar2(10)      ,/* 營運據點 */
deaadocno       varchar2(20)      ,/* 單據編號 */
deaaseq       number(10,0)      ,/* 對帳項次 */
deaaseq1       number(10,0)      ,/* 導入項次 */
deaa003       varchar2(30)      ,/* 款別類型對應憑証號(卡號) */
deaa004       number(20,6)      ,/* 差異金額 */
deaa005       varchar2(1)      ,/* 是否處理 */
deaa006       varchar2(10)      ,/* 處理方法 */
deaa007       varchar2(20)      ,/* 專櫃編號 */
deaa008       varchar2(10)      ,/* 班別 */
deaa009       varchar2(20)      ,/* 收銀員編號 */
deaa010       varchar2(10)      ,/* 收銀機編號 */
deaa011       varchar2(8)      ,/* 收銀時間 */
deaa012       number(20,6)      ,/* 本幣收款金額 */
deaa013       varchar2(40)      ,/* 導入刷卡機號 */
deaa014       varchar2(8)      ,/* 導入刷卡時間 */
deaa015       number(20,6)      ,/* 導入金額 */
deaa016       varchar2(80)      ,/* 導入交易對象 */
deaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deaaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deaa_t add constraint deaa_pk primary key (deaaent,deaadocno,deaaseq) enable validate;

create unique index deaa_pk on deaa_t (deaaent,deaadocno,deaaseq);

grant select on deaa_t to tiptop;
grant update on deaa_t to tiptop;
grant delete on deaa_t to tiptop;
grant insert on deaa_t to tiptop;

exit;
