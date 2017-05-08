/* 
================================================================================
檔案代號:imah_t
檔案名稱:NO USE
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table imah_t
(
imahent       number(5)      ,/* 企業編號 */
imahsite       varchar2(10)      ,/* 營運據點 */
imah001       varchar2(40)      ,/* 料件編號 */
imah011       varchar2(10)      ,/* 稅別 */
imah012       varchar2(10)      ,/* 稅則編號 */
imah013       number(20,6)      ,/* 保稅年度盤差容許率 */
imah014       varchar2(10)      ,/* 保稅統計類別 */
imah015       varchar2(10)      ,/* 保稅群組代碼 */
imah016       number(20,6)      ,/* 保稅應補稅稅率 */
imah017       number(20,6)      ,/* 保稅單價 */
imah018       varchar2(10)      ,/* 保稅料件型態 */
imah019       varchar2(30)      ,/* 帳號編號 */
imahownid       varchar2(20)      ,/* 資料所有者 */
imahowndp       varchar2(10)      ,/* 資料所屬部門 */
imahcrtid       varchar2(20)      ,/* 資料建立者 */
imahcrtdt       timestamp(0)      ,/* 資料創建日 */
imahcrtdp       varchar2(10)      ,/* 資料建立部門 */
imahmodid       varchar2(20)      ,/* 資料修改者 */
imahmoddt       timestamp(0)      ,/* 最近修改日 */
imahcnfid       varchar2(20)      ,/* 資料確認者 */
imahcnfdt       timestamp(0)      ,/* 資料確認日 */
imahstus       varchar2(10)      ,/* 狀態碼 */
imahud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imahud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imahud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imahud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imahud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imahud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imahud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imahud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imahud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imahud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imahud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imahud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imahud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imahud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imahud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imahud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imahud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imahud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imahud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imahud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imahud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imahud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imahud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imahud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imahud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imahud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imahud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imahud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imahud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imahud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imah_t add constraint imah_pk primary key (imahent,imahsite,imah001) enable validate;

create  index imah_01 on imah_t (imah011);
create unique index imah_pk on imah_t (imahent,imahsite,imah001);

grant select on imah_t to tiptop;
grant update on imah_t to tiptop;
grant delete on imah_t to tiptop;
grant insert on imah_t to tiptop;

exit;
