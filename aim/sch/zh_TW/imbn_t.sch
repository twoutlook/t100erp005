/* 
================================================================================
檔案代號:imbn_t
檔案名稱:料件申請料號據點關務檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table imbn_t
(
imbnent       number(5)      ,/* 企業編號 */
imbnsite       varchar2(10)      ,/* 營運據點 */
imbndocno       varchar2(20)      ,/* 申請單號 */
imbn001       varchar2(40)      ,/* 料件編號 */
imbn011       varchar2(10)      ,/* 關務分群 */
imbn012       varchar2(1)      ,/* 保稅否 */
imbn013       varchar2(10)      ,/* 保稅料件型態 */
imbn014       varchar2(10)      ,/* 保稅料區分 */
imbn021       varchar2(10)      ,/* 保稅統計類別 */
imbn022       number(20,6)      ,/* 保稅年度盤差容許率 */
imbn023       varchar2(20)      ,/* 稅則編號 */
imbn024       number(5,2)      ,/* 保稅應補稅稅率 */
imbn025       number(20,6)      ,/* 保稅單價 */
imbn031       number(20,6)      ,/* 推廣貿易服務費 */
imbn032       varchar2(40)      ,/* 稅則 */
imbn033       varchar2(30)      ,/* 帳卡編號 */
imbn034       varchar2(1)      ,/* 受託加工成品 */
imbnownid       varchar2(20)      ,/* 資料所有者 */
imbnowndp       varchar2(10)      ,/* 資料所屬部門 */
imbncrtid       varchar2(20)      ,/* 資料建立者 */
imbncrtdp       varchar2(10)      ,/* 資料建立部門 */
imbncrtdt       timestamp(0)      ,/* 資料創建日 */
imbnmodid       varchar2(20)      ,/* 資料修改者 */
imbnmoddt       timestamp(0)      ,/* 最近修改日 */
imbncnfid       varchar2(20)      ,/* 資料確認者 */
imbncnfdt       timestamp(0)      ,/* 資料確認日 */
imbnpstid       varchar2(20)      ,/* 資料過帳者 */
imbnpstdt       timestamp(0)      ,/* 資料過帳日 */
imbnstus       varchar2(10)      ,/* 狀態碼 */
imbnacti       varchar2(1)      ,/* 資料有效碼 */
imbnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imbnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imbnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imbnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imbnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imbnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imbnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imbnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imbnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imbnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imbnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imbnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imbnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imbnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imbnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imbnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imbnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imbnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imbnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imbnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imbnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imbnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imbnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imbnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imbnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imbnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imbnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imbnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imbnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imbnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imbn_t add constraint imbn_pk primary key (imbnent,imbnsite,imbndocno) enable validate;

create unique index imbn_pk on imbn_t (imbnent,imbnsite,imbndocno);

grant select on imbn_t to tiptop;
grant update on imbn_t to tiptop;
grant delete on imbn_t to tiptop;
grant insert on imbn_t to tiptop;

exit;
