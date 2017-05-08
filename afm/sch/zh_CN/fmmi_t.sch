/* 
================================================================================
檔案代號:fmmi_t
檔案名稱:資金進出市場檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmmi_t
(
fmmient       number(5)      ,/* 企業代碼 */
fmmiseq       number(10,0)      ,/* 項次 */
fmmisite       varchar2(10)      ,/* 投資組織 */
fmmi001       varchar2(10)      ,/* 交易市場 */
fmmi002       date      ,/* 日期 */
fmmi003       varchar2(20)      ,/* 銀行收支單號 */
fmmi004       number(10,0)      ,/* 收支單項次 */
fmmi005       varchar2(10)      ,/* 幣別 */
fmmi006       number(20,6)      ,/* 金額 */
fmmi007       varchar2(1)      ,/* 異動別 */
fmmi008       varchar2(20)      ,/* 投資審核單號 */
fmmiownid       varchar2(20)      ,/* 資料所有者 */
fmmiowndp       varchar2(10)      ,/* 資料所屬部門 */
fmmicrtid       varchar2(20)      ,/* 資料建立者 */
fmmicrtdp       varchar2(10)      ,/* 資料建立部門 */
fmmicrtdt       timestamp(0)      ,/* 資料創建日 */
fmmimodid       varchar2(20)      ,/* 資料修改者 */
fmmimoddt       timestamp(0)      ,/* 最近修改日 */
fmmicnfid       varchar2(20)      ,/* 資料確認者 */
fmmicnfdt       timestamp(0)      ,/* 資料確認日 */
fmmipstid       varchar2(20)      ,/* 資料過帳者 */
fmmipstdt       timestamp(0)      ,/* 資料過帳日 */
fmmistus       varchar2(10)      ,/* 狀態碼 */
fmmiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmiud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmmi009       number(20,10)      /* 匯率 */
);
alter table fmmi_t add constraint fmmi_pk primary key (fmmient,fmmiseq,fmmisite,fmmi001) enable validate;

create unique index fmmi_pk on fmmi_t (fmmient,fmmiseq,fmmisite,fmmi001);

grant select on fmmi_t to tiptop;
grant update on fmmi_t to tiptop;
grant delete on fmmi_t to tiptop;
grant insert on fmmi_t to tiptop;

exit;
