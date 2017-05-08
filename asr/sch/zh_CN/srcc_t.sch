/* 
================================================================================
檔案代號:srcc_t
檔案名稱:重複性生產計劃製程變更檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table srcc_t
(
srccent       number(5)      ,/* 企業代碼 */
srccsite       varchar2(10)      ,/* 營運據點 */
srcc000       varchar2(1)      ,/* 類型 */
srcc001       varchar2(10)      ,/* 生產計劃 */
srcc002       varchar2(10)      ,/* 製程編號 */
srcc004       varchar2(40)      ,/* 料件編號 */
srcc005       varchar2(30)      ,/* BOM特性 */
srcc006       varchar2(256)      ,/* 產品特徵 */
srcc007       number(10,0)      ,/* 項次 */
srcc008       varchar2(10)      ,/* 本站作業編號 */
srcc009       varchar2(10)      ,/* 作業序 */
srcc010       varchar2(10)      ,/* 群組性質 */
srcc011       varchar2(10)      ,/* 群組 */
srcc012       varchar2(10)      ,/* 上站作業 */
srcc013       varchar2(10)      ,/* 上站作業序 */
srcc014       varchar2(10)      ,/* 下站作業 */
srcc015       varchar2(10)      ,/* 下站作業序 */
srcc016       varchar2(10)      ,/* 工作站 */
srcc017       number(15,3)      ,/* 固定工時 */
srcc018       number(15,3)      ,/* 標準工時 */
srcc019       number(15,3)      ,/* 固定機時 */
srcc020       number(15,3)      ,/* 標準機時 */
srcc021       varchar2(1)      ,/* Move in */
srcc022       varchar2(1)      ,/* Check in */
srcc023       varchar2(1)      ,/* 報工站 */
srcc024       varchar2(1)      ,/* PQC */
srcc025       varchar2(1)      ,/* Check out */
srcc026       varchar2(1)      ,/* Move out */
srcc027       varchar2(10)      ,/* 轉出單位 */
srcc028       number(20,6)      ,/* 單位轉換率分子 */
srcc029       number(20,6)      ,/* 單位轉換率分母 */
srcc030       number(20,6)      ,/* 待Move in數 */
srcc031       number(20,6)      ,/* 待Check in數 */
srcc032       number(20,6)      ,/* 在制數 */
srcc033       number(20,6)      ,/* 待PQC數 */
srcc034       number(20,6)      ,/* 待Check out數 */
srcc035       number(20,6)      ,/* 待Move out數 */
srcc036       varchar2(1)      ,/* 委外 */
srcc037       varchar2(10)      ,/* 委外廠商 */
srcc038       number(20,6)      ,/* 良品轉入 */
srcc039       number(20,6)      ,/* 重工轉入 */
srcc040       number(20,6)      ,/* 良品轉出 */
srcc041       number(20,6)      ,/* 重工轉出 */
srcc042       number(20,6)      ,/* 當站報廢 */
srcc043       number(20,6)      ,/* 當站下線 */
srcc044       number(20,6)      ,/* 委外數量 */
srcc045       number(20,6)      ,/* 委外完工數量 */
srcc046       varchar2(10)      ,/* 轉入單位 */
srcc047       number(20,6)      ,/* 轉入單位轉換率分子 */
srcc048       number(20,6)      ,/* 轉入單位轉換率分母 */
srcc900       number(10,0)      ,/* 變更序 */
srcc901       varchar2(1)      ,/* 變更類型 */
srcc902       date      ,/* 變更日期 */
srcc905       varchar2(10)      ,/* 變更理由 */
srcc906       varchar2(255)      ,/* 變更備註 */
srccud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
srccud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
srccud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
srccud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
srccud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
srccud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
srccud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
srccud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
srccud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
srccud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
srccud011       number(20,6)      ,/* 自定義欄位(數字)011 */
srccud012       number(20,6)      ,/* 自定義欄位(數字)012 */
srccud013       number(20,6)      ,/* 自定義欄位(數字)013 */
srccud014       number(20,6)      ,/* 自定義欄位(數字)014 */
srccud015       number(20,6)      ,/* 自定義欄位(數字)015 */
srccud016       number(20,6)      ,/* 自定義欄位(數字)016 */
srccud017       number(20,6)      ,/* 自定義欄位(數字)017 */
srccud018       number(20,6)      ,/* 自定義欄位(數字)018 */
srccud019       number(20,6)      ,/* 自定義欄位(數字)019 */
srccud020       number(20,6)      ,/* 自定義欄位(數字)020 */
srccud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
srccud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
srccud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
srccud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
srccud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
srccud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
srccud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
srccud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
srccud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
srccud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table srcc_t add constraint srcc_pk primary key (srccent,srccsite,srcc000,srcc001,srcc002,srcc004,srcc005,srcc006,srcc007,srcc900) enable validate;

create unique index srcc_pk on srcc_t (srccent,srccsite,srcc000,srcc001,srcc002,srcc004,srcc005,srcc006,srcc007,srcc900);

grant select on srcc_t to tiptop;
grant update on srcc_t to tiptop;
grant delete on srcc_t to tiptop;
grant insert on srcc_t to tiptop;

exit;
