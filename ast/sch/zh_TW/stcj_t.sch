/* 
================================================================================
檔案代號:stcj_t
檔案名稱:分銷費用單明細資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stcj_t
(
stcjent       number(5)      ,/* 企業編號 */
stcjunit       varchar2(10)      ,/* 應用組織 */
stcjsite       varchar2(10)      ,/* 營運據點 */
stcjdocno       varchar2(20)      ,/* 單據編號 */
stcjseq       number(10,0)      ,/* 項次 */
stcj001       varchar2(10)      ,/* 來源類別 */
stcj002       varchar2(20)      ,/* 來源單號 */
stcj003       number(10,0)      ,/* 來源項次 */
stcj004       varchar2(10)      ,/* 費用編號 */
stcj005       varchar2(10)      ,/* 幣別 */
stcj006       varchar2(10)      ,/* 稅別 */
stcj007       varchar2(10)      ,/* 價款類別 */
stcj008       date      ,/* 起始日期 */
stcj009       date      ,/* 截止日期 */
stcj010       number(10,0)      ,/* 業務結算期 */
stcj011       number(5,0)      ,/* 財務會計年度 */
stcj012       number(5,0)      ,/* 財務會計期別 */
stcj013       number(20,6)      ,/* 費用金額 */
stcj014       varchar2(10)      ,/* 結算對象 */
stcj015       varchar2(10)      ,/* 承擔對象 */
stcj016       varchar2(10)      ,/* 交易對象類別 */
stcj017       varchar2(10)      ,/* 經銷商 */
stcj018       varchar2(10)      ,/* 網點 */
stcj019       varchar2(10)      ,/* 經營方式 */
stcj020       varchar2(10)      ,/* 結算類別 */
stcj021       varchar2(10)      ,/* 結算方式 */
stcj022       varchar2(10)      ,/* 銷售組織 */
stcj023       varchar2(10)      ,/* 銷售範圍 */
stcj024       varchar2(10)      ,/* 銷售渠道 */
stcj025       varchar2(10)      ,/* 產品組 */
stcj026       varchar2(10)      ,/* 辦事處 */
stcj027       varchar2(10)      ,/* 所屬品類 */
stcj028       varchar2(10)      ,/* 所屬部門 */
stcjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stcjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stcjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stcjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stcjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stcjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stcjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stcjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stcjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stcjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stcjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stcjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stcjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stcjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stcjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stcjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stcjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stcjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stcjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stcjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stcjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stcjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stcjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stcjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stcjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stcjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stcjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stcjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stcjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stcjud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stcj029       varchar2(10)      ,/* 現返折扣類型 */
stcj030       varchar2(10)      ,/* 現返類型 */
stcj031       varchar2(10)      ,/* 現返摘要編號 */
stcj032       number(20,6)      ,/* 現返已返金額 */
stcj033       varchar2(20)      ,/* 合約編號 */
stcj034       number(10,0)      ,/* 合約折扣條件項次 */
stcj035       varchar2(10)      /* 現返理由碼 */
);
alter table stcj_t add constraint stcj_pk primary key (stcjent,stcjdocno,stcjseq) enable validate;

create unique index stcj_pk on stcj_t (stcjent,stcjdocno,stcjseq);

grant select on stcj_t to tiptop;
grant update on stcj_t to tiptop;
grant delete on stcj_t to tiptop;
grant insert on stcj_t to tiptop;

exit;
