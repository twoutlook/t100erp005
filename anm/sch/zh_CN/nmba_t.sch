/* 
================================================================================
檔案代號:nmba_t
檔案名稱:銀存收支主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table nmba_t
(
nmbaent       number(5)      ,/* 企業編號 */
nmbaownid       varchar2(20)      ,/* 資料所有者 */
nmbaowndp       varchar2(10)      ,/* 資料所有部門 */
nmbacrtid       varchar2(20)      ,/* 資料建立者 */
nmbacrtdp       varchar2(10)      ,/* 資料建立部門 */
nmbacrtdt       timestamp(0)      ,/* 資料創建日 */
nmbamodid       varchar2(20)      ,/* 資料修改者 */
nmbamoddt       timestamp(0)      ,/* 最近修改日 */
nmbacnfid       varchar2(20)      ,/* 資料確認者 */
nmbacnfdt       timestamp(0)      ,/* 資料確認日 */
nmbastus       varchar2(10)      ,/* 確認碼 */
nmbacomp       varchar2(10)      ,/* 法人 */
nmbadocno       varchar2(20)      ,/* 收支單號 */
nmbadocdt       date      ,/* 收支日期 */
nmbasite       varchar2(10)      ,/* 資金中心 */
nmba001       varchar2(10)      ,/* 繳款部門 */
nmba002       varchar2(20)      ,/* 帳務人員 */
nmba003       varchar2(20)      ,/* 來源作業類型 */
nmba004       varchar2(10)      ,/* 交易對象 */
nmba005       varchar2(20)      ,/* 一次性交易對象識別碼 */
nmba006       varchar2(1)      ,/* 暫收否 */
nmba007       varchar2(20)      ,/* 帳務單號 */
nmba008       varchar2(20)      ,/* 繳款人員 */
nmba009       date      ,/* 核准日期 */
nmba010       varchar2(20)      ,/* 帳套二帳務單號 */
nmba011       varchar2(20)      ,/* 帳套三帳務單號 */
nmbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmbaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
nmba012       varchar2(1)      ,/* 立帳否(for流通) */
nmba013       date      ,/* 起始日期 */
nmba014       date      /* 截止日期 */
);
alter table nmba_t add constraint nmba_pk primary key (nmbaent,nmbacomp,nmbadocno) enable validate;

create unique index nmba_pk on nmba_t (nmbaent,nmbacomp,nmbadocno);

grant select on nmba_t to tiptop;
grant update on nmba_t to tiptop;
grant delete on nmba_t to tiptop;
grant insert on nmba_t to tiptop;

exit;
