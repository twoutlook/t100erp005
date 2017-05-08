/* 
================================================================================
檔案代號:sfob_t
檔案名稱:工單製程變更單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfob_t
(
sfobent       number(5)      ,/* 企業代碼 */
sfobsite       varchar2(10)      ,/* 營運據點 */
sfobdocno       varchar2(20)      ,/* 工單單號 */
sfob001       number(10,0)      ,/* RUN CARD */
sfob002       number(10,0)      ,/* 項次 */
sfob003       varchar2(10)      ,/* 本站作業 */
sfob004       varchar2(10)      ,/* 製程序 */
sfob005       varchar2(1)      ,/* 群組性質 */
sfob006       varchar2(10)      ,/* 群組 */
sfob007       varchar2(10)      ,/* 上站作業 */
sfob008       varchar2(10)      ,/* 上站製程序 */
sfob009       varchar2(10)      ,/* 下站作業 */
sfob010       varchar2(10)      ,/* 下站製程序 */
sfob011       varchar2(10)      ,/* 工作站 */
sfob012       varchar2(1)      ,/* 允許委外 */
sfob013       varchar2(10)      ,/* 主要加工廠 */
sfob014       varchar2(1)      ,/* Move in */
sfob015       varchar2(1)      ,/* Check in */
sfob016       varchar2(1)      ,/* 報工站 */
sfob017       varchar2(1)      ,/* PQC */
sfob018       varchar2(1)      ,/* Check out */
sfob019       varchar2(1)      ,/* Move out */
sfob020       varchar2(10)      ,/* 轉出單位 */
sfob021       number(20,6)      ,/* 轉出單位轉換率分子 */
sfob022       number(20,6)      ,/* 轉出單位轉換率分母 */
sfob023       number(15,3)      ,/* 固定工時 */
sfob024       number(15,3)      ,/* 標準工時 */
sfob025       number(15,3)      ,/* 固定機時 */
sfob026       number(15,3)      ,/* 標準機時 */
sfob027       number(20,6)      ,/* 標準產出量 */
sfob028       number(20,6)      ,/* 良品轉入 */
sfob029       number(20,6)      ,/* 重工轉入 */
sfob030       number(20,6)      ,/* 工單轉入 */
sfob031       number(20,6)      ,/* 分割轉入 */
sfob032       number(20,6)      ,/* 合併轉入 */
sfob033       number(20,6)      ,/* 良品轉出 */
sfob034       number(20,6)      ,/* 重工轉出 */
sfob035       number(20,6)      ,/* 工單轉出 */
sfob036       number(20,6)      ,/* 當站報廢 */
sfob037       number(20,6)      ,/* 當站下線 */
sfob038       number(20,6)      ,/* 分割轉出 */
sfob039       number(20,6)      ,/* 合併轉出 */
sfob040       number(20,6)      ,/* Bonus */
sfob041       number(20,6)      ,/* 委外加工數 */
sfob042       number(20,6)      ,/* 委外完工數 */
sfob043       number(20,6)      ,/* 盤點數 */
sfob044       date      ,/* 預計開工日 */
sfob045       date      ,/* 預計完工日 */
sfob046       number(20,6)      ,/* 待Move in數 */
sfob047       number(20,6)      ,/* 待Check in數 */
sfob048       number(20,6)      ,/* 待Check out數 */
sfob049       number(20,6)      ,/* 待Move out數 */
sfob050       number(20,6)      ,/* 在製數 */
sfob051       number(20,6)      ,/* 待PQC數 */
sfob052       varchar2(10)      ,/* 轉入單位 */
sfob053       number(20,6)      ,/* 轉入單位轉換率分子 */
sfob054       number(20,6)      ,/* 轉入單位轉換率分母 */
sfob900       number(10,0)      ,/* 變更序 */
sfob901       varchar2(1)      ,/* 變更類型 */
sfob902       date      ,/* 變更日期 */
sfob905       varchar2(10)      ,/* 變更理由 */
sfob906       varchar2(255)      ,/* 變更備註 */
sfob055       varchar2(1)      ,/* 回收站 */
sfobud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfobud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfobud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfobud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfobud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfobud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfobud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfobud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfobud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfobud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfobud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfobud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfobud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfobud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfobud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfobud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfobud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfobud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfobud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfobud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfobud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfobud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfobud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfobud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfobud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfobud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfobud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfobud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfobud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfobud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfob_t add constraint sfob_pk primary key (sfobent,sfobdocno,sfob001,sfob002,sfob900) enable validate;

create unique index sfob_pk on sfob_t (sfobent,sfobdocno,sfob001,sfob002,sfob900);

grant select on sfob_t to tiptop;
grant update on sfob_t to tiptop;
grant delete on sfob_t to tiptop;
grant insert on sfob_t to tiptop;

exit;
