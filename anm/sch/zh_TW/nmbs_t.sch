/* 
================================================================================
檔案代號:nmbs_t
檔案名稱:帳務底稿主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table nmbs_t
(
nmbsent       number(5)      ,/* 企業編號 */
nmbssite       varchar2(10)      ,/* 帳務中心 */
nmbscomp       varchar2(10)      ,/* 法人 */
nmbsld       varchar2(5)      ,/* 帳套 */
nmbsdocno       varchar2(20)      ,/* 帳務單號 */
nmbsdocdt       date      ,/* 帳務單日期 */
nmbs001       varchar2(10)      ,/* 作業來源 */
nmbs002       number(10,0)      ,/* 附件張數 */
nmbs003       varchar2(20)      ,/* 傳票編號 */
nmbs004       date      ,/* 傳票日期 */
nmbsownid       varchar2(20)      ,/* 資料所有者 */
nmbsowndp       varchar2(10)      ,/* 資料所屬部門 */
nmbscrtid       varchar2(20)      ,/* 資料建立者 */
nmbscrtdp       varchar2(10)      ,/* 資料建立部門 */
nmbscrtdt       timestamp(0)      ,/* 資料創建日 */
nmbsmodid       varchar2(20)      ,/* 資料修改者 */
nmbsmoddt       timestamp(0)      ,/* 最近修改日 */
nmbscnfid       varchar2(20)      ,/* 資料確認者 */
nmbscnfdt       timestamp(0)      ,/* 資料確認日 */
nmbsstus       varchar2(10)      ,/* 狀態碼 */
nmbsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmbsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmbsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmbsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmbsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmbsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmbsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmbsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmbsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmbsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmbsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmbsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmbsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmbsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmbsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmbsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmbsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmbsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmbsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmbsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmbsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmbsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmbsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmbsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmbsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmbsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmbsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmbsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmbsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmbsud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmbs_t add constraint nmbs_pk primary key (nmbsent,nmbsld,nmbsdocno) enable validate;

create unique index nmbs_pk on nmbs_t (nmbsent,nmbsld,nmbsdocno);

grant select on nmbs_t to tiptop;
grant update on nmbs_t to tiptop;
grant delete on nmbs_t to tiptop;
grant insert on nmbs_t to tiptop;

exit;
