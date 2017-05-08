/* 
================================================================================
檔案代號:oofg_t
檔案名稱:自動編碼設定資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oofg_t
(
oofgent       number(5)      ,/* 企業編號 */
oofgownid       varchar2(20)      ,/* 資料所有者 */
oofgowndp       varchar2(10)      ,/* 資料所屬部門 */
oofgcrtid       varchar2(20)      ,/* 資料建立者 */
oofgcrtdp       varchar2(10)      ,/* 資料建立部門 */
oofgcrtdt       timestamp(0)      ,/* 資料創建日 */
oofgmodid       varchar2(20)      ,/* 資料修改者 */
oofgmoddt       timestamp(0)      ,/* 最近修改日 */
oofgstus       varchar2(10)      ,/* 狀態碼 */
oofg001       varchar2(10)      ,/* 編碼分類 */
oofg002       varchar2(10)      ,/* 編碼性質 */
oofg003       number(5,0)      ,/* 總編號長度 */
oofg004       varchar2(40)      ,/* 案例 */
oofg005       varchar2(10)      ,/* 節點編號 */
oofg006       varchar2(10)      ,/* 前段節點編號 */
oofg007       number(5,0)      ,/* 段次 */
oofg008       varchar2(10)      ,/* 節點型態 */
oofg009       number(5,0)      ,/* 長度 */
oofg010       varchar2(40)      ,/* 固定值 */
oofg011       varchar2(20)      ,/* 數值範圍起 */
oofg012       varchar2(20)      ,/* 數值範圍迄 */
oofg013       varchar2(2000)      ,/* 抓取欄位值的SQL */
oofg014       number(5,0)      ,/* 擷取碼長起 */
oofg015       number(5,0)      ,/* 擷取碼長迄 */
oofg016       varchar2(1)      ,/* 使用轉換表 */
oofg017       varchar2(10)      ,/* 轉換表號 */
oofg018       varchar2(1)      ,/* 連動欄位 */
oofg019       varchar2(20)      ,/* 目的欄位 */
oofg020       varchar2(40)      ,/* 欄位值 */
oofg021       varchar2(1)      ,/* 加入特徵值 */
oofg022       varchar2(10)      ,/* 特徵組別 */
oofg023       varchar2(10)      ,/* 特徵類型 */
oofgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oofgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oofgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oofgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oofgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oofgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oofgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oofgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oofgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oofgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oofgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oofgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oofgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oofgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oofgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oofgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oofgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oofgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oofgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oofgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oofgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oofgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oofgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oofgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oofgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oofgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oofgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oofgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oofgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oofgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oofg_t add constraint oofg_pk primary key (oofgent,oofg001,oofg005) enable validate;

create  index oofg_01 on oofg_t (oofg002);
create unique index oofg_pk on oofg_t (oofgent,oofg001,oofg005);

grant select on oofg_t to tiptop;
grant update on oofg_t to tiptop;
grant delete on oofg_t to tiptop;
grant insert on oofg_t to tiptop;

exit;
