/* 
================================================================================
檔案代號:stdl_t
檔案名稱:經銷商代墊費用報銷明細資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stdl_t
(
stdlent       number(5)      ,/* 企業編號 */
stdlunit       varchar2(10)      ,/* 應用組織 */
stdlsite       varchar2(10)      ,/* 營運據點 */
stdldocno       varchar2(20)      ,/* 單號編號 */
stdlseq       number(10,0)      ,/* 項次 */
stdl001       varchar2(10)      ,/* 對象類型 */
stdl002       varchar2(10)      ,/* 經銷商 */
stdl003       varchar2(10)      ,/* 網點編號 */
stdl004       varchar2(10)      ,/* 費用編號 */
stdl005       varchar2(10)      ,/* 價款類型 */
stdl006       varchar2(10)      ,/* 幣別 */
stdl007       varchar2(10)      ,/* 稅別 */
stdl008       number(20,6)      ,/* 報銷金額 */
stdl009       date      ,/* 起始日期 */
stdl010       date      ,/* 截止日期 */
stdl011       number(10,0)      ,/* 結算會計期 */
stdl012       varchar2(20)      ,/* 合同編號 */
stdl013       varchar2(10)      ,/* 經營方式 */
stdl014       varchar2(10)      ,/* 結算方式 */
stdl015       varchar2(10)      ,/* 結算類型 */
stdl016       varchar2(10)      ,/* 結算中心 */
stdl017       varchar2(30)      ,/* 促銷方式 */
stdl018       varchar2(10)      ,/* 銷售範圍 */
stdl019       varchar2(10)      ,/* 銷售組織 */
stdl020       varchar2(10)      ,/* 銷售渠道 */
stdl021       varchar2(10)      ,/* 產品組 */
stdl022       varchar2(10)      ,/* 辦事處 */
stdl023       varchar2(80)      ,/* 備註 */
stdlud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stdlud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stdlud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stdlud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stdlud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stdlud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stdlud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stdlud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stdlud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stdlud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stdlud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stdlud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stdlud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stdlud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stdlud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stdlud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stdlud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stdlud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stdlud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stdlud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stdlud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stdlud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stdlud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stdlud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stdlud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stdlud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stdlud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stdlud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stdlud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stdlud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stdl_t add constraint stdl_pk primary key (stdlent,stdldocno,stdlseq) enable validate;

create unique index stdl_pk on stdl_t (stdlent,stdldocno,stdlseq);

grant select on stdl_t to tiptop;
grant update on stdl_t to tiptop;
grant delete on stdl_t to tiptop;
grant insert on stdl_t to tiptop;

exit;
